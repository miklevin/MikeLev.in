I am going to have to guide Gemini through understanding the Botify API.

---

## Understanding Botify API

**Me**: Find the other occurrence of this query. Analyze how one is the to request the export of the CSV file while the other is just to get a count at a particular click-depth. Write a little article here about what you discover.

**Claude**: 

## Understanding Botify API Requests: Exporting CSVs vs. Counting URLs by Depth

The Botify export workflow in `50_botify_export.py` interacts with the Botify API in two fundamentally different ways, depending on the user's needs. These two operations—**exporting a CSV file** and **counting URLs at a particular click-depth**—are implemented with distinct API payloads and serve different purposes in the workflow.

### 1. Requesting a CSV Export (`export_payload`)

**Where it appears:**  
The `export_payload` is constructed in the `initiate_export_job` method. This payload is used when the user wants to export a set of URLs (and optionally, their metadata) as a CSV file from Botify.

**How it works:**  
- The payload is sent to the `/v1/jobs` endpoint of the Botify API.
- It specifies a `job_type` of `"export"`, and the `payload` includes:
  - The organization and project.
  - The connector (`"direct_download"`) and formatter (`"csv"`).
  - The maximum export size (e.g., 1,000,000 URLs).
  - A `query` object that defines which fields (dimensions) to include, which depth to filter by, and how to sort the results.
- The query can include additional fields like page title, meta description, and H1 headings, depending on user selection.
- The API responds with a job URL, which the workflow then polls for completion and, eventually, for a download link to the CSV.

**Purpose:**  
This request is about **data extraction**. It is designed to generate a downloadable CSV file containing all URLs (and selected metadata) up to a certain depth, for further analysis or reporting.

---

### 2. Counting URLs by Click-Depth (`payload` in `get_urls_by_depth`)

**Where it appears:**  
The `payload` for counting URLs is constructed in the `get_urls_by_depth` method. This is used in the workflow step that determines the "maximum safe click depth"—the deepest level of the site that can be exported without exceeding a set URL limit (e.g., 1 million URLs).

**How it works:**  
- The payload is sent to the `/v1/projects/{org}/{project}/query` endpoint.
- It specifies a `query` with:
  - `dimensions`: Only the depth field (e.g., `crawl.{analysis}.depth`).
  - `metrics`: The count of URLs at each depth (e.g., `count_urls_crawl`).
  - `sort`: Orders the results by depth.
- The API responds with a breakdown of how many URLs exist at each depth.

**Purpose:**  
This request is about **data analysis**. It is not extracting URLs, but rather **summarizing** the structure of the crawl data. The workflow uses this information to help the user select a depth that will not exceed the export limit, ensuring the export job will succeed.

---

### Key Differences

| Aspect                | CSV Export (`export_payload`)                | Count by Depth (`payload` in `get_urls_by_depth`) |
|-----------------------|----------------------------------------------|---------------------------------------------------|
| **API Endpoint**      | `/v1/jobs`                                   | `/v1/projects/{org}/{project}/query`              |
| **Purpose**           | Download URLs (and metadata) as CSV          | Get counts of URLs at each depth                   |
| **Query Content**     | Full URL data, metadata, filters, sorting    | Only depth and count metrics                       |
| **Result**            | Downloadable CSV file                        | JSON with depth:count mapping                      |
| **Workflow Step**     | Step 4: Export configuration and download    | Step 3: Calculate safe export depth                |

---

### Why This Matters

- **Export jobs** are resource-intensive and can fail if too much data is requested. By first **counting URLs by depth**, the workflow can guide the user to a safe export configuration.
- The **count query** is lightweight and fast, while the **export job** is asynchronous and may take time to process, requiring polling and download management.
- The two requests are tightly integrated: the count query informs the export job, ensuring a smooth and user-friendly experience.

---

**In summary:**  
The Botify export workflow uses a two-step approach: first, it analyzes the data to determine safe export parameters (using a count query), and then it initiates a full export job to generate and download the CSV. Each step uses a different API payload, tailored to its specific purpose—one for analysis, one for extraction. This separation of concerns is key to both reliability and usability in large-scale data workflows.

---

## BQLv2 Documentation

**Me**: Document what you've learned about BQLv2. Actually provide code
examples. Include things like how you can neither leave out the metrics field
even if you have to include it and just leave it empty. Really read through
those comments to found the wisdom left for you on this front.

**Claude**: 

## BQLv2 in Practice: Lessons from the Botify Export Workflow

### What is BQLv2?

BQLv2 (Botify Query Language v2) is the query format used by Botify’s API for both data extraction (export jobs) and analytical queries (like URL counts by depth). It is a JSON-based query language that specifies which fields (dimensions), metrics, filters, and sorting to apply to a dataset.

### Key Lessons from the Code

#### 1. **You Must Always Include the `metrics` Field**

Even if you don’t want any metrics (for example, when exporting raw URLs and metadata), the `metrics` field **cannot be omitted**. If you don’t need any metrics, you must include it as an empty list:

```python
query = {
    "dimensions": [
        f"crawl.{analysis}.url",
        # ...other fields...
    ],
    "metrics": [],  # <-- Must be present, even if empty!
    "sort": [{"field": f"crawl.{analysis}.url", "order": "asc"}],
    "filters": {
        "field": f"crawl.{analysis}.depth",
        "predicate": "lte",
        "value": int(depth)
    }
}
```

**Wisdom from the code:**  
> "You can neither leave out the metrics field even if you have to include it and just leave it empty."

#### 2. **The Structure of a BQLv2 Query**

A typical BQLv2 query (as seen in both export and count requests) looks like this:

```python
query = {
    "dimensions": [ ... ],  # List of fields to include (e.g., URL, title, etc.)
    "metrics": [ ... ],     # List of metrics to compute (can be empty)
    "sort": [ ... ],        # Sorting instructions
    "filters": { ... }      # Filtering conditions
}
```

#### 3. **Export Job Example**

When requesting a CSV export, the query is wrapped in a job payload:

```python
export_payload = {
    "job_type": "export",
    "payload": {
        "username": org,
        "project": project,
        "connector": "direct_download",
        "formatter": "csv",
        "export_size": 1000000,
        "query": {
            "collections": [f"crawl.{analysis}"],
            "query": query  # The BQLv2 query as above
        }
    }
}
```

**Example with selected fields:**

```python
dimensions = [
    f"crawl.{analysis}.url",
    f"crawl.{analysis}.metadata.title.content",
    f"crawl.{analysis}.metadata.description.content"
]
query = {
    "dimensions": dimensions,
    "metrics": [],
    "sort": [{"field": f"crawl.{analysis}.url", "order": "asc"}],
    "filters": {
        "field": f"crawl.{analysis}.depth",
        "predicate": "lte",
        "value": int(depth)
    }
}
```

#### 4. **Count-at-Depth Example**

When you want to count URLs at each depth, you must include a metric (e.g., `count_urls_crawl`):

```python
payload = {
    "collections": [f"crawl.{analysis}"],
    "query": {
        "dimensions": [f"crawl.{analysis}.depth"],
        "metrics": [{"field": f"crawl.{analysis}.count_urls_crawl"}],
        "sort": [{"field": f"crawl.{analysis}.depth", "order": "asc"}]
    }
}
```

#### 5. **General BQLv2 Rules and Gotchas**

- **`metrics` is always required** (even if empty).
- **`dimensions` is always required**.
- **`sort` is highly recommended** for predictable results.
- **`filters`** can be a single object or a list, depending on complexity.
- **`collections`** wraps the dataset you’re querying (usually one per query).

#### 6. **Error Handling and Debugging**

The code is careful to catch and log errors from the API, and to check for required fields in the response. If you get an error, double-check that your BQLv2 query includes all required fields, especially `metrics`.

---

## Summary Table

| Field         | Required | Notes                                                      |
|---------------|----------|------------------------------------------------------------|
| `dimensions`  | Yes      | List of fields to return (e.g., URL, title, depth, etc.)   |
| `metrics`     | Yes      | List of metrics to compute (can be empty, but must exist)  |
| `sort`        | Yes      | List of sort instructions                                  |
| `filters`     | Optional | Filtering conditions (e.g., depth <= N)                    |
| `collections` | Yes      | List of collections (datasets) to query                    |

---

## Example: Minimal BQLv2 Query for Export

```python
query = {
    "dimensions": [f"crawl.{analysis}.url"],
    "metrics": [],  # Must be present!
    "sort": [{"field": f"crawl.{analysis}.url", "order": "asc"}],
    "filters": {
        "field": f"crawl.{analysis}.depth",
        "predicate": "lte",
        "value": int(depth)
    }
}
```

## Example: BQLv2 Query for Counting URLs by Depth

```python
query = {
    "dimensions": [f"crawl.{analysis}.depth"],
    "metrics": [{"field": f"crawl.{analysis}.count_urls_crawl"}],
    "sort": [{"field": f"crawl.{analysis}.depth", "order": "asc"}]
}
```

---

## Final Wisdom

- **Never omit the `metrics` field, even if you don’t need metrics.**
- **Always check the API docs and your error logs for required fields.**
- **Use the code’s patterns as a template for your own BQLv2 queries.**

This approach ensures your Botify API requests will be well-formed and robust, whether you’re exporting data or analyzing it!

---

## A Tale of Two Endpoints

**Me**: This is good, but I think it ignores the fact that there is a major
difference between the two types of queries, one to get an aggregate count that
has org and project in the URL and one endpoint, and the other that asks for a
CSV export that has org and project in the payload and a different endpoint.
Please produce documentation on this fact, putting it in no unclear terms how
the payloads and endpoints are similar but different between the two query
types. Compare and contrast a similar query under each, one doing a simple
"listing" and the other dong the export request for that same list. Don't forget
about the API nuances like not leaving out a metrics field even if has to be
empty in either case.

**Claude**: 

Absolutely! Here’s a clear, side-by-side documentation of the **two major Botify API query types** as implemented in your codebase, with a focus on their **endpoint, payload, and usage differences**—plus a direct comparison of how you’d request the same data (a simple URL listing) via each method.

---

# Botify API: Aggregate Count vs. CSV Export

## 1. **Aggregate Count Query (Analysis/Preview/Count)**

### **Endpoint**
```
POST https://api.botify.com/v1/projects/{org}/{project}/query
```
- The **org** and **project** are part of the URL path.

### **Purpose**
- Used for **analytics**: to get aggregate data, such as the number of URLs at each depth.
- **Does not** return the actual URLs, just summary statistics.

### **Payload Example: Count URLs by Depth**
```python
payload = {
    "collections": [f"crawl.{analysis}"],
    "query": {
        "dimensions": [f"crawl.{analysis}.depth"],
        "metrics": [{"field": f"crawl.{analysis}.count_urls_crawl"}],  # Must be present!
        "sort": [{"field": f"crawl.{analysis}.depth", "order": "asc"}]
    }
}
```
- **metrics**: Required, even if you only want dimensions. For counts, you specify a metric.
- **dimensions**: What to group by (e.g., depth).
- **sort**: For predictable ordering.

### **Returns**
- JSON with aggregate counts, e.g.:
  ```json
  [
    {"dimensions": [0], "metrics": [123]},
    {"dimensions": [1], "metrics": [456]},
    ...
  ]
  ```

---

## 2. **CSV Export Query (Export Job)**

### **Endpoint**
```
POST https://api.botify.com/v1/jobs
```
- The **org** and **project** are part of the **payload**, not the URL.

### **Purpose**
- Used for **data extraction**: to request a downloadable CSV of URLs (and optionally, metadata).
- Returns a **job URL** to poll for completion and download.

### **Payload Example: Export URLs up to a Depth**
```python
export_payload = {
    "job_type": "export",
    "payload": {
        "username": org,
        "project": project,
        "connector": "direct_download",
        "formatter": "csv",
        "export_size": 1000000,
        "query": {
            "collections": [f"crawl.{analysis}"],
            "query": {
                "dimensions": [f"crawl.{analysis}.url"],  # List URLs
                "metrics": [],  # Must be present, even if empty!
                "sort": [{"field": f"crawl.{analysis}.url", "order": "asc"}],
                "filters": {
                    "field": f"crawl.{analysis}.depth",
                    "predicate": "lte",
                    "value": int(depth)
                }
            }
        }
    }
}
```
- **metrics**: Must be present, even if empty (for pure listings).
- **dimensions**: The fields to include in the CSV (e.g., URL, title, etc.).
- **filters**: To restrict to a certain depth.
- **org/project**: In the payload, not the URL.

### **Returns**
- JSON with a `job_url` to poll for status and, eventually, a download link.

---

## **Direct Comparison: Listing URLs**

### **A. Count Query (How many URLs at each depth?)**
- **Endpoint:** `/v1/projects/{org}/{project}/query`
- **Purpose:** Get counts, not the actual URLs.
- **Payload:**
    ```python
    {
        "collections": [f"crawl.{analysis}"],
        "query": {
            "dimensions": [f"crawl.{analysis}.depth"],
            "metrics": [{"field": f"crawl.{analysis}.count_urls_crawl"}],
            "sort": [{"field": f"crawl.{analysis}.depth", "order": "asc"}]
        }
    }
    ```

### **B. Export Query (Get the actual URLs as CSV)**
- **Endpoint:** `/v1/jobs`
- **Purpose:** Get the actual URLs (and metadata) as a downloadable CSV.
- **Payload:**
    ```python
    {
        "job_type": "export",
        "payload": {
            "username": org,
            "project": project,
            "connector": "direct_download",
            "formatter": "csv",
            "export_size": 1000000,
            "query": {
                "collections": [f"crawl.{analysis}"],
                "query": {
                    "dimensions": [f"crawl.{analysis}.url"],
                    "metrics": [],  # Must be present, even if empty!
                    "sort": [{"field": f"crawl.{analysis}.url", "order": "asc"}],
                    "filters": {
                        "field": f"crawl.{analysis}.depth",
                        "predicate": "lte",
                        "value": int(depth)
                    }
                }
            }
        }
    }
    ```

---

## **Key Differences Table**

| Feature         | Count Query (Aggregate)                        | Export Query (CSV)                        |
|-----------------|------------------------------------------------|-------------------------------------------|
| **Endpoint**    | `/v1/projects/{org}/{project}/query`           | `/v1/jobs`                                |
| **Org/Project** | In URL path                                    | In payload                                |
| **Purpose**     | Get summary stats (counts, groupings)          | Get actual data (URLs, metadata)          |
| **Returns**     | JSON with aggregates                           | JSON with job URL for CSV download        |
| **metrics**     | Required, must specify at least one metric     | Required, can be empty if just listing    |
| **dimensions**  | What to group by (e.g., depth)                 | What to include in CSV (e.g., URL, title) |
| **filters**     | Optional, for restricting data                 | Optional, for restricting data            |
| **sort**        | Recommended                                    | Recommended                              |

---

## **API Nuances and Gotchas**

- **metrics is always required** in both query types. For exports, it can be an empty list if you just want a listing; for counts, you must specify a metric.
- **org and project**: In the count query, these are in the URL; in the export, they are in the payload.
- **Endpoints are not interchangeable**: You cannot use the export payload at the count endpoint or vice versa.
- **Export jobs are asynchronous**: You must poll the returned job URL to get the download link.

---

## **Summary**

- **Use `/v1/projects/{org}/{project}/query`** for analytics and counts—org/project in the URL, metrics required, returns aggregates.
- **Use `/v1/jobs`** for CSV exports—org/project in the payload, metrics required (can be empty), returns a job URL for download.

**Always include the `metrics` field, even if empty, and always use the correct endpoint for your use case.**

---

This distinction is critical for anyone working with the Botify API: **the endpoint, payload structure, and intent are different, even if the queries look similar!**

---

**Me**: Excellent! Now I need you to also know about BQLv1 because there are
different types of exports that can only be done with the older API. Here is an
example of doing an export at a particular click-depth, doing the export and
various other things. Excuse the sloppiness of the code. It also mixes in BQLv2
examples. But the request is to examine this and to provide various examples of
using BQLv1 inferred from and extracted from these examples with a special
emphasis on documenting how BQLv1 is different from BQLv2.

```python
import pandas as pd
from pathlib import Path

use_bql_version = "v1"
max_depth = 4

# Define your organization, project, and analysis identifiers

org = "example-org"
project = "example.com"
analysis = "20240705"


def export_data(version, org, project, export_payload, report_path, analysis=None, retry_url=None):
    """
    Unified function to export data using BQLv1 or BQLv2
    version must be v1 or v2
    
    """
    file_base = report_path.stem
    path_base = Path(report_path).parent
    zip_name = path_base / f"{file_base}.gz"
    csv_name = Path(report_path)

    path_base.mkdir(parents=True, exist_ok=True)  # Ensure the directory exists before proceeding

    if csv_name.exists():
        print(f"The file: {csv_name}")
        print("...already exists for analysis period. Exiting.")
        return (None, None)

    if zip_name.exists():
        print(f"{zip_name} found without corresponding CSV. Decompressing now...")
        decompress_success = decompress_gz(zip_name, csv_name)
        return (200, None) if decompress_success else (None, None)

    if retry_url:
        print(f"Using retry URL for direct download: {retry_url}")
        if download_file(retry_url, zip_name):  # Save as .gz file
            print("File downloaded successfully via retry URL.")
            if decompress_gz(zip_name, csv_name):  # Decompress .gz to .csv
                print("File decompressed successfully.")
                return (200, csv_name)
            else:
                print("Decompression failed.")
                return (None, None)
        else:
            print("Download failed using retry URL.")
            return (None, None)

    headers = {'Authorization': f'Token {api.key}', 'Content-Type': 'application/json'}

    if version == 'v1':
        url = f'https://api.botify.com/v1/analyses/{org}/{project}/{analysis}/urls/export'
        response = requests.post(url, headers=headers, json=export_payload)
    else:  # version == 'v2'
        url = "https://api.botify.com/v1/jobs"
        response = requests.post(url, headers=headers, json=export_payload)

    if response.status_code not in [200, 201]:
        print(f"Failed to start CSV export. Status Code: {response.status_code}.")
        print(response.reason, response.text)
        pprint(export_payload)
        return (response.status_code, None)

    export_job_details = response.json()
    job_url = export_job_details.get('job_url')
    if version == "v2":
        job_url = f'https://api.botify.com{job_url}'

    attempts = 300
    delay = 10
    print(f"{attempts} attempts will be made every {delay} seconds until download is ready...")

    while attempts > 0:
        sleep(delay)
        print(attempts, end=" ", flush=True)  # Countdown on the same line
        response_poll = requests.get(job_url, headers=headers)
        if response_poll.status_code == 200:
            job_status_details = response_poll.json()
            if job_status_details['job_status'] == 'DONE':
                print("\nExport job done.")
                download_url = job_status_details['results']['download_url']
                if download_file(download_url, zip_name):
                    print("File downloaded successfully.")
                    if decompress_gz(zip_name, csv_name):
                        print("File decompressed successfully.")
                        return (200, csv_name)
                    else:
                        print("Decompression failed.")
                        return ("Decompression failed 1.", None)
                else:
                    print("Download failed.")
                    return ("Decompression failed 2.", None)
            elif job_status_details['job_status'] == 'FAILED':
                print("\nExport job failed.")
                print(job_status_details.get('failure_reason', 'No failure reason provided.'))
                return ("Export job failed.", None)
        else:
            print(f"\nFailed to get export status. Status Code: {response_poll.status_code}")
            print(response_poll.text)

        attempts -= 1

    print("Unable to complete download attempts successfully.")
    return ("Unable to complete", None)


def download_file(download_url, output_path):
    response = requests.get(download_url, stream=True)
    if response.status_code == 200:
        output_path.parent.mkdir(parents=True, exist_ok=True)  # Ensure the directory exists
        with open(output_path, "wb") as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        return True
    else:
        print(f"Failed to download file. Status Code: {response.status_code}")
        return False


def decompress_gz(gz_path, output_path):
    import gzip
    import shutil
    try:
        with gzip.open(gz_path, 'rb') as f_in, open(output_path, 'wb') as f_out:
            shutil.copyfileobj(f_in, f_out)
        print(f"Decompressed {output_path}")
        return True
    except Exception as e:
        print(f"Failed to decompress {gz_path}. Error: {e}")
        return False


def manage_project_analysis(project_dir):
    """Find the newest folder in the given base directory or create a new analysis directory based on the latest slug."""
    import datetime

    from dateutil.relativedelta import relativedelta

    newest_date = None
    newest_folder = None

    # Current date and threshold date (one month minus a day from current date)
    current_date = datetime.datetime.now().date()
    threshold_date = current_date - relativedelta(months=1)
    check_dir = project_dir / "analysis"
    check_dir.mkdir(parents=True, exist_ok=True)

    # Check for the latest folder
    for folder in check_dir.iterdir():
        if folder.is_dir() and folder.name.isdigit() and len(folder.name) == 8:
            try:
                folder_date = datetime.datetime.strptime(folder.name, "%Y%m%d").date()
                if newest_date is None or folder_date > newest_date:
                    newest_date = folder_date
                    newest_folder = folder
            except ValueError:
                continue

    if newest_folder and newest_date > threshold_date:
        return newest_folder
    else:
        # Only hits the API if newest folder is older than 1 month
        parts = project_dir.parts
        if len(parts) != 3:
            print(f"Double check your project URL for {project_dir}. Portion of URL missing.")
            raise SystemExit()

        _, org, project = parts
        print("Getting last Analysis date...")
        slugs = fetch_analysis_slugs(org, project)
        if slugs:
            latest_slug = slugs[0]
            analysis_dir = project_dir / "analysis" / latest_slug
            analysis_dir.mkdir(exist_ok=True, parents=True)
            return analysis_dir
        else:
            print(f"No new analysis slugs available for {project} in {org}.")
            return None


# Set up the data directory structure
data_dir = Path("data")
if not data_dir.exists():
    data_dir.mkdir()
    print(f"Created directory: {data_dir}")

project_dir = data_dir / org / project
project_dir.mkdir(exist_ok=True, parents=True)

if not analysis:
    analysis_dir = manage_project_analysis(project_dir)
else:
    analysis_dir = data_dir / org / project / "analysis" / analysis

analysis_dir.mkdir(parents=True, exist_ok=True)

print(f"{analysis_dir}")

# Example Wedge: Create a sub-folder for SEMrush gap analysis in the new slug folder
# BQLv1 API endpoint and initial setup
print(f"Exporting Depth {max_depth}...")

# Data payload for the BQLv1 query
data_payload_v1 = {
    "filters": {
        "predicate": "lte",
        "value": max_depth,
        "field": "depth"
    },
    "fields": [
        "url",
        "outlinks_internal.graph.url",
        "depth"
    ],
    "sort": []
}

# Data payload for the BQLv2 query
data_payload_v2 = {
    "job_type": "export",
    "payload": {
        "username": org,
        "project": project,
        "connector": "direct_download",
        "formatter": "csv",
        "export_size": 10000,
        "query": {
            "collections": [f"crawl.{analysis}"],
            "query": {
                "dimensions": [
                    "url",
                    f"crawl.{analysis}.outlinks_internal.graph.url",
                    f"crawl.{analysis}.depth"
                ],
                "metrics": [],
                "filters": {
                    "field": f"crawl.{analysis}.depth",
                    "predicate": "eq",
                    "value": max_depth
                }
            }
        }
    }
}

# Define the path prefix and report name for the CSV export
path_prefix = data_dir / org / project / "analysis" / analysis / "link_graph"
report_name = path_prefix / f"depth-lte-{max_depth}-3col.csv"

# Check if the file already exists
if report_name.exists():
    print(f"File {report_name} already exists. Skipping the export.")
else:
    # BQLv1 Query using the unified export function
    if use_bql_version == "v1":
        status_code, report_path = export_data(
            version='v1',
            org=org,
            project=project,
            export_payload=data_payload_v1,
            report_path=report_name,
            analysis=analysis
        )
    # BQLv2 Query using the unified export function
    else:
        status_code, report_path = export_data(
            version='v2',
            org=org,
            project=project,
            export_payload=data_payload_v2,
            report_path=report_name,
            analysis=analysis
        )

# Outputting Depths
print("Outputting Depths...")
if report_name.exists():
    if use_bql_version == "v1":
        # BQLv1 requires skipping sep=, on row 1
        df = pd.read_csv(report_name, skiprows=1)
    else:
        df = pd.read_csv(report_name)
        # BQLv2 doesn't insert column labels (investigate)
        df.columns =  ["URL", "To", "Depth"]

    for depth in range(max_depth + 1):
        df_filtered = df[df["Depth"] <= depth].drop(columns=["Depth"])
        output_file = path_prefix / f"depth-lte-{depth}.csv"
        df_filtered.to_csv(output_file, index=False)
    print("Files made")
print("Done")

print("Getting meta data...")

# Data payload for the metadata query
data_payload_v1 = {
    "filters": {
        "predicate": "lte",
        "value": max_depth + 1,
        "field": "depth"
    },
    "fields": [
        "url",
        "depth",
        "internal_page_rank.position",
        "internal_page_rank.value",
        "internal_page_rank.raw"
    ],
    "sort": []
}

data_payload_v1 = {
    "filters": {
        "predicate": "lte",
        "value": max_depth + 1,
        "field": "depth"
    },
    "fields": [
        "url",
        "depth",
        "gsc_by_url.count_impressions",
        "gsc_by_url.count_clicks",
        "segments.pagetype.depth_1",
        # "segments.parameters.value",
        # "gsc_by_url.avg_position",
        # "gsc_by_url.count_keywords",
        # "gsc_by_url.count_keywords_on_url_to_achieve_90pc_clicks",
        
        #"compliant.is_compliant",
        "search_engines.google.crawls.count",
        
        #"segments.pagetype.depth_1",
        # "segments.parameters.depth_1",
        "internal_page_rank.position",
        "internal_page_rank.value",
        "internal_page_rank.raw",
        
        # "search_engines.google.crawls.http_codes.statuses",
        # "search_engines.google.visits.count",
        # "search_engines.google.visits.http_codes.statuses",
        # "canonical.to.equal",
        # "sitemaps.present",
        # "content_quality.pct_ngrams_1",
        # "content_quality.nb_simscore_pct_75",
        # "content_quality.nb_words_total",
        # "ActionBoard_ML.prob_crawled__initial",
        # "ActionBoard_ML.prob_active__initial",
        # "scoring.issues.slow_first_to_last_byte_compliant",
        # "scoring.issues.slow_render_time_compliant",
        # "scoring.issues.slow_server_time_compliant",
        # "scoring.issues.slow_load_time_compliant",
        # "scoring.issues.nb_hops",
        #"metadata.structured.product.exists"
    ],
    "sort": []
}
report_name = path_prefix / f"meta.csv"

# Check if the file already exists
if report_name.exists():
    print(f"File {report_name} already exists. Skipping the export.")
else:
    # BQLv1 Query for metadata
    status_code, report_path = bf.export_data(
        version='v1',
        org=org,
        project=project,
        export_payload=data_payload_v1,
        report_path=report_name,
        analysis=analysis
    )

if report_name.exists():
    df = pd.read_csv(report_name, skiprows=1)
    
    report_name = path_prefix / f"meta-id.csv"
    df.rename(columns={'Full URL': 'id'}, inplace=True)
    df.to_csv(report_name, index=False)
```

And some additional guidance:

# Migrating from BQLv1 to BQLv2

This guide explains how to convert BQLv1 queries to BQLv2 format, with practical examples and validation helpers.

## Core Concepts

### API Endpoint Changes

- **BQLv1**: `/v1/analyses/{username}/{website}/{analysis}/urls`
- **BQLv2**: `/v1/projects/{username}/{website}/query`

### Key Structural Changes

1. Collections replace URL parameters
2. Fields become dimensions
3. All fields require collection prefixes
4. Areas are replaced with explicit filters

## Query Conversion Examples

### 1. Basic URL Query

```json
// BQLv1 (/v1/analyses/user/site/20210801/urls?area=current&previous_crawl=20210715)
{
  "fields": [
    "url",
    "http_code",
    "previous.http_code"
  ],
  "filters": {
    "field": "indexable.is_indexable",
    "predicate": "eq",
    "value": true
  }
}

// BQLv2 (/v1/projects/user/site/query)
{
  "collections": [
    "crawl.20210801",
    "crawl.20210715"
  ],
  "query": {
    "dimensions": [
      "crawl.20210801.url",
      "crawl.20210801.http_code",
      "crawl.20210715.http_code"
    ],
    "metrics": [],
    "filters": {
      "field": "crawl.20210801.indexable.is_indexable",
      "predicate": "eq",
      "value": true
    }
  }
}
```

### 2. Aggregation Query

```json
// BQLv1 (/v1/analyses/user/site/20210801/urls/aggs)
[
  {
    "aggs": [
      {
        "metrics": ["count"],
        "group_by": [
          {
            "distinct": {
              "field": "segments.pagetype.depth_1",
              "order": {"value": "asc"},
              "size": 300
            }
          }
        ]
      }
    ]
  }
]

// BQLv2
{
  "collections": ["crawl.20210801"],
  "query": {
    "dimensions": [
      "crawl.20210801.segments.pagetype.depth_1"
    ],
    "metrics": [
      "crawl.20210801.count_urls_crawl"
    ],
    "sort": [0]
  }
}
```

### 3. Area Filters

BQLv1's area parameter is replaced with explicit filters in BQLv2:

#### New URLs Filter
```json
{
  "and": [
    {
      "field": "crawl.20210801.url_exists_crawl",
      "value": true
    },
    {
      "field": "crawl.20210715.url_exists_crawl",
      "value": false
    }
  ]
}
```

#### Disappeared URLs Filter
```json
{
  "and": [
    {
      "field": "crawl.20210801.url_exists_crawl",
      "value": false
    },
    {
      "field": "crawl.20210715.url_exists_crawl",
      "value": true
    }
  ]
}
```

## Conversion Helper Functions

```python
def validate_bql_v2(query):
    """Validate BQLv2 query structure"""
    required_keys = {'collections', 'query'}
    query_keys = {'dimensions', 'metrics', 'filters'}
    
    if not all(key in query for key in required_keys):
        raise ValueError(f"Missing required keys: {required_keys}")
    if not any(key in query['query'] for key in query_keys):
        raise ValueError(f"Query must contain one of: {query_keys}")
    for collection in query['collections']:
        if not collection.startswith('crawl.'):
            raise ValueError(f"Invalid collection format: {collection}")
    return True

def convert_url_query(query_v1, current_analysis, previous_analysis=None):
    """Convert BQLv1 URL query to BQLv2"""
    collections = [f"crawl.{current_analysis}"]
    if previous_analysis:
        collections.append(f"crawl.{previous_analysis}")
    
    # Convert fields to dimensions
    dimensions = []
    for field in query_v1.get('fields', []):
        if field.startswith('previous.'):
            if not previous_analysis:
                raise ValueError("Previous analysis required for previous fields")
            field = field.replace('previous.', '')
            dimensions.append(f"crawl.{previous_analysis}.{field}")
        else:
            dimensions.append(f"crawl.{current_analysis}.{field}")
    
    # Convert filters
    filters = None
    if 'filters' in query_v1:
        filters = {
            "field": f"crawl.{current_analysis}.{query_v1['filters']['field']}",
            "predicate": query_v1['filters']['predicate'],
            "value": query_v1['filters']['value']
        }
    
    query_v2 = {
        "collections": collections,
        "query": {
            "dimensions": dimensions,
            "metrics": [],
            "filters": filters
        }
    }
    
    validate_bql_v2(query_v2)
    return query_v2
```

## Key Conversion Rules

1. **Collections**
   - Add `collections` array with `crawl.{analysis}` format
   - Include both analyses for comparison queries

2. **Fields to Dimensions**
   - Prefix fields with `crawl.{analysis}.`
   - Replace `previous.` prefix with `crawl.{previous_analysis}.`

3. **Metrics**
   - Convert aggregation metrics to appropriate BQLv2 metric fields
   - Use empty array when no metrics needed

4. **Filters**
   - Prefix filter fields with collection name
   - Replace area parameters with explicit URL existence filters

PROMPT:

Document the difference between BQLv1 and BQLv2, both for the simple "list" API
endpoint, and for doing CSV exports.

THE KEY REQUIREMENT IS NOT TO DO INTEGRATION! THE KEY REQUIREMENT IS TO PRODUCE
THE DOCUMENTATION DIFFERENTIATING BQLV1 FROM BQLV2, PROVIDING EXAMPLES FOR THE 2
ENDPOINTS FOR EACH, AND PROVIDING EXAMPLES OF USING THE LIST VS. THE EXPORT FOR
EACH. BE CRYSTAL CLEAR ABOUT THE DIFFERENCES BETWEEN THE TWO, GIVEN THE
EXAMPLES.
