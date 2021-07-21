Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37E03D1860
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGUUJM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 16:09:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13578 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhGUUJM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 16:09:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LKkNle032050;
        Wed, 21 Jul 2021 20:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AekJ3ia6FFrPbw41u+XLYyElUZY/Im/qhINmliZNu1M=;
 b=Idy6t4snmnu3CAXdmmbBp+6232Ai4Ara3cSxeCcjU3vLZWWFPQo4VVU0obRhpuZMFqD+
 RsN0xc3DReyzHcFOBLYCIyRvsm0h5PB5wzEyX/TV7Hzo+F/TSOO9Slu7UTHYwhAsbB9+
 HL77SeWF1W6yq+03lCXNjr/4aR33dRbF4RHeKIJcM30qHna5kI4C7X2SdKQRPhr6JbeH
 x/lGtfzBx3lv6WOTNLUofMQjxxcgmRPgRbYCMfpr6/FoEYrz16e5Xb9mNuuh+4e+2wX8
 Ux9Q4LJ+YYyvENj+LBIERKp31WSGuZMKxBnYUO3ajM2qo7BG/CBXVR5kS5mH7D3utxNv 9Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AekJ3ia6FFrPbw41u+XLYyElUZY/Im/qhINmliZNu1M=;
 b=rV/y+bz9Zd55z5Dp50sOkB9rEw2gWcJ/FeHCIfVVvJ69IZb1YLwe5gPoAS3VspTxOohL
 v360SPEBHfBqXzoT1uoTSEYZRQ3tH7zRKLe44ssqSEiO/M+w2f5LNJIaMbboLGtA/pJ3
 11qX+DgxnHgYNrsUOgpIEwppqJFRIuh4vaCRJfwwva5EfvhwdSbU773OOp5aas/Q0SK9
 YRkaWVH91aV8vxx1vZ67UHnhHDub2P3pHlQvgzJARk+WwhR+jQJQnqjebPgSVio/F0Yr
 ea9ZC7ltvc838ZNxtU23rsQoOAPhHq1AhGMWKc5h+hIVDgoU1IvMLMQNJVXJPlptL+P3 nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39w9hfxahw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 20:49:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LKkQKA128096;
        Wed, 21 Jul 2021 20:49:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3020.oracle.com with ESMTP id 39v8yy6hxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 20:49:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5p26ulZPpwQjm8CWh7z/joI6+jAZWNPoIvYfOXtgNtcsMCr1zPxwVCnnY6AsDLYwhvo1lIgoMiJblYYHQ3DS9gaWdv8BWz1IpBwjLqQl8p0Pgk0+Zb3FXtskgHmF68w5VHVe89YoB/ZNAdCf954nXqmYDigm5J5aMiZtlKWHslZhGEtaDSyHK8MACx2qBFiiNyCu/C4rXC3ADnFXEWtvRpORB8ysEMtytiTmgFm0oz5kmpveYerlWztREoKLeJmoadPl60nAX/8cUTLoFzym2GqHY/lb9lTLZAZd88c5eqoUjk+T6IQ6zXqBeGy35ffB5dFi/xtG/ohT0N3adIq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AekJ3ia6FFrPbw41u+XLYyElUZY/Im/qhINmliZNu1M=;
 b=EU9mi+/pEJKGKc+fTPBtB6JQWAjIACHabbNw/MvHjsIT9ungAYZ1AZdSbiUoQdUk1j6+k1ABz9r8Nbj4Rm0LcV/EYYTg+Rx+fMNyiiPKhMxD9pghIzE/6/jzuZSZbt7tznPUhvtbFdWa/qv0i4MlBSJwqUUNmlu0vC7rAuHv2Fc2X7UkCq/LprNlLKHn1ofVeWAF3DvVuKRfFlHYiziViUY24+gLYzV11n2DlQCMjHkVISbkDEGecLjY4y3OPgSMOaHYoYtymExHvTuAGXtkwB4DaglaThBHjMXkKoC3xp5c8VNxBtauCuFjsZVEjREXunevE5dGgB9Y0TTbVcnecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AekJ3ia6FFrPbw41u+XLYyElUZY/Im/qhINmliZNu1M=;
 b=xKH/F1OQXE9Sx13FhzUNbNHXBgHu/pieUegIhySo6nZjgswt6ml4pMfOk1nBxnjnppSrVo3V8XzaG/CORd3Djya/LYzAiofv5uNxxaPm0LhyMAJZLrmeZQsepsxPb405g5RbWz+AYlHwv67gu5XJTgxNkanw5lXquz/3r+SPlEw=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2456.namprd10.prod.outlook.com (2603:10b6:a02:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 20:49:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 20:49:18 +0000
Subject: Re: [PATCH v6 4/6] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
To:     Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-5-git-send-email-feng.tang@intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7cdf88d8-9eea-5547-ee77-7d46829bf2dd@oracle.com>
Date:   Wed, 21 Jul 2021 13:49:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <1626077374-81682-5-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:300:6c::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR04CA0060.namprd04.prod.outlook.com (2603:10b6:300:6c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 20:49:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e79c02ef-e45f-4ee1-5dc4-08d94c890202
X-MS-TrafficTypeDiagnostic: BYAPR10MB2456:
X-Microsoft-Antispam-PRVS: <BYAPR10MB245614D8DC48F1E608A984F1E2E39@BYAPR10MB2456.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrW9AFViwsr52/vibDYPxtM4i1cbBxVHHRjKsikrZIG4ETFovgyKpbFPHJ0Vb1O0hgWR+qGOpRaC3ZbsgirDEg3vqKHvUh7jIe9AFahRt6RvIRZc1TYX1GVRQFBoWHgU4cUKanr0PMFenk8YC3a6+XdI3waomiwSoV4fvqOBuAdSctFsKBZtArCruyUauoHPczBR6YvvSz86NLx972Vxvm+fxrO/GBGt/4VstrQwQbZbqe/uXSBsxSzoJa/lBDtgyg/2IPk9xvKBtM+aFqyQgpcVOx9IYeL9mx/06NTJCTZpptg8rwigQ9KjY/z6Kf8DmlM/wb//LPC8XQbK0U6llHu4pq/b/44JB9EZQcEx/zUSLd8MFjOIE0Wc8RP7HG6RWbxUtXhuhloHDe3IsFXzRkuuOLQr1Nzf684yi7k/lapeMyyX6YkCxzeKvlFNnWnlpcQi3QUxTGAeh6oV3LbCB5J6GGFrl/L5cqlZutEqlf+9TSWgxOkuF6Ob3j56JPy5MH2n/5+gnEECjfczg3qn4XFfouyx27tGhiR87zDolliAMPR2DDpxhnTs+0S+BE5ZUT7ECLLd5PJUu0+PL/sYZsoOHoHO34wboX1OkWXeEAERgLXkpeqhQgbh+L9QaeUAW1vrMA9xoBltkGvt23feyi+M+OgoGDBTxENV4gqBTEWVrGsHuyBB94gS/Aj79+xj4jaPNo5pWQos3Sh0cZHwqW6q//ZGxkR9LfvsFuFw3W+26trXO1lXRjgINptBVL/rtlCzr/gu8rsxZIidQqm478v5WyQ8ARPAQ7tAB/NaaNZXeec/jEf8jNMPKjU0yVoWChAFsBhOYous+3aYWeykWu7KuLuAdJHnarCTW4mYtaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(4326008)(38350700002)(5660300002)(186003)(86362001)(7416002)(2906002)(53546011)(26005)(110136005)(36756003)(31696002)(8676002)(966005)(8936002)(52116002)(83380400001)(6486002)(316002)(478600001)(38100700002)(44832011)(31686004)(66556008)(2616005)(956004)(66476007)(66946007)(54906003)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hpQlJSd29oQ3pqcWwybTVGMWUySVU5cjYvcFNONVBjV2pnVVdHcWh3M1g0?=
 =?utf-8?B?NFpsTENVc2EySlJmcE1INFNhTmlKN0FQT0tMOXp2RnMxZ1FacTdvaXJUVnFr?=
 =?utf-8?B?dlVIMW13RHR6T0x6M3AyRHN3M0VHVFJ4TUF3Q011TFhEQktUZ0hWMUVMZ0tm?=
 =?utf-8?B?d2Y5WTFFNCtROHFHVmZwOFduWG5xWnNiT0hHQ2UrWW1QM2EzWVFEMXBuc1BS?=
 =?utf-8?B?NVFPOGNEOTlLdTYybXMzNnQrc21USXJ0enI2KzQydlJydmlkUFdwYThkSTdp?=
 =?utf-8?B?dWltS2theTZCVUYzdVpHQk5GTTduaXVUcVBJQXpzNEtnazU4dGdYQkpWeHZk?=
 =?utf-8?B?WG5TTnpSMkpBa1libjVnbjlZWUpCay83alh5WWNEaGxqZXoySEFVbks4Mjkz?=
 =?utf-8?B?ck1VSEVzRTY5QVdxSDVjMVhycEdub0hqRE1vek9BOEJ2cjNkQVR3cmRycnA3?=
 =?utf-8?B?K0lLQ2JRMUdXcmN1aE5VajJpNkhPU1E3QWh3c2lVY0VMbUxuZjlwaUtmSDg3?=
 =?utf-8?B?b1JqcXRtb0dBVEtNeWh1R1J0bUxOTU1ZWUNJQ2hmOFQ2OGh4WTg3Z0VicEtE?=
 =?utf-8?B?RUF3c0ZnUmt3eGYvSDk4dmZGck1oTnZMWkl1TlkxU2FYU3p1N08vYyswdEVY?=
 =?utf-8?B?VW5Nem9jaTFhaitKNEN3Y2pYN0hVSXRUMXlQYWJFcjExckJ5clo2bHloYVJX?=
 =?utf-8?B?dWhQQndGdXNUOWZLaGxGOGM4WDJEVUZ3aldXYzg1M01tc0lNSEcrOTJySW95?=
 =?utf-8?B?UTV4Y2F5Y0RJdGRCWE9iSlMzblVHNWVrbzBMOXhxay9mQzNDTlN4TXJMUTVt?=
 =?utf-8?B?RWxsQnRDTVpIVmtWT1U4cEl5aDQ1bHZ2MWZFZHlpa2ZCU3RiQUlzRHdwb1hG?=
 =?utf-8?B?QldXZVpMcEdBdW84cEVpVjMrY2owRC94ek1rRkpGVjB4U1hTZWswOVNFbEpW?=
 =?utf-8?B?S2JtWlo1ZWZ4QlU5bEgyMlFvUjcrZk9RTmVycXU3VUxBbWc2Vzg0c09LZmo2?=
 =?utf-8?B?OEhpSVh5SXRkZXMrT1dsUXVrYWE2cVNYTHdXUjN0QlY5bHpkY3RNL0llM2xO?=
 =?utf-8?B?cnFoUCtIdGg3dkE1TFhaQ3daVHplQjY5OEZIU0ZYV25XZGZwQVlzSFErdHdG?=
 =?utf-8?B?NFZleS9KUnBRQjBFQU9VemxacGNyRHJyTTZxbHN5dm5kaHdiVUEzWENkMHFw?=
 =?utf-8?B?RnRITmdXT0lnQm1vVFAxWHVtaXFodVJSUU1ybXl4djJISTZyZ1FxNTNEUDJC?=
 =?utf-8?B?UnB2S3kxSm55UUNOR1FtWkN4dzZMVFRxYXIrMy9OMm5vSUhHTnRMQ3pIcm51?=
 =?utf-8?B?TDhLRjNOSGYvYkJYN2VEc2sxWENGQXFJWFhTQzM1Nm9YVUJqTUhKUFhieFlm?=
 =?utf-8?B?VWFTYUFpT0pSR2dUQTdidkNZZ0o0ZnRMWmNObmtyZ201ajBCeHJHQTk3QmU0?=
 =?utf-8?B?L2NkTmpTMWZTUmt0dHFQOTk2em5MRnU5UDRqdEI4S0JzZzZFcXRlQnJ1VTUy?=
 =?utf-8?B?NjFFbnBoS2VpZkN4THNqK05pbStOQzhsUVg4V2kxV21QRE9jVDhteHUvZ1dv?=
 =?utf-8?B?SU42RUI2WlhqZmRWS2xPRVhUWE94a3pkZTlBY1NNakRFQVRuRUlQRzZlWGYz?=
 =?utf-8?B?dVAwSDNNZjE5bFp1dE45VEJITXpydjlNbU9XbkQ3c1BkR3dEcTVpUndVTUNw?=
 =?utf-8?B?Wit1N3ZHMkgzeVRpUFF0UUd4N3hsRTFEK3RhM0tUMnBnWGdta3NRV2JWTHBr?=
 =?utf-8?Q?gBxOrDsvKhPrFfQYLKuCab+8yszTuW+VByhOXcy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79c02ef-e45f-4ee1-5dc4-08d94c890202
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 20:49:18.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhxyvlRWfJBGJ3EzMzs0ZvReJWPXndY2yrjnB/G+ViQmXgPG2DoFtbQDWnTzWt3UbfdJ0w8LT+I1hU5lwRckZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2456
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210123
X-Proofpoint-GUID: csScsQIxhfIUpOrNptcb9J9sQah7xWhX
X-Proofpoint-ORIG-GUID: csScsQIxhfIUpOrNptcb9J9sQah7xWhX
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/12/21 1:09 AM, Feng Tang wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Implement the missing huge page allocation functionality while obeying
> the preferred node semantics. This is similar to the implementation
> for general page allocation, as it uses a fallback mechanism to try
> multiple preferred nodes first, and then all other nodes.
> 
> [Thanks to 0day bot for caching the missing #ifdef CONFIG_NUMA issue]
> 
> Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Co-developed-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/hugetlb.c   | 25 +++++++++++++++++++++++++
>  mm/mempolicy.c |  3 ++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 924553aa8f78..3e84508c1b8c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1164,7 +1164,18 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  
>  	gfp_mask = htlb_alloc_mask(h);
>  	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> +#ifdef CONFIG_NUMA
> +	if (mpol->mode == MPOL_PREFERRED_MANY) {
> +		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> +		if (page)
> +			goto check_reserve;
> +		/* Fallback to all nodes */
> +		nodemask = NULL;
> +	}
> +#endif
>  	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> +
> +check_reserve:
>  	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
>  		SetHPageRestoreReserve(page);
>  		h->resv_huge_pages--;
> @@ -2095,6 +2106,20 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  	nodemask_t *nodemask;
>  
>  	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
> +#ifdef CONFIG_NUMA
> +	if (mpol->mode == MPOL_PREFERRED_MANY) {
> +		gfp_t gfp = (gfp_mask | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM;

I believe __GFP_NOWARN will be added later in alloc_buddy_huge_page, so
no need to add here?

> +
> +		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
> +		if (page) {
> +			mpol_cond_put(mpol);
> +			return page;
> +		}
> +
> +		/* Fallback to all nodes */
> +		nodemask = NULL;
> +	}
> +#endif
>  	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
>  	mpol_cond_put(mpol);
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 9dce67fc9bb6..93f8789758a7 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2054,7 +2054,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
>  					huge_page_shift(hstate_vma(vma)));
>  	} else {
>  		nid = policy_node(gfp_flags, *mpol, numa_node_id());
> -		if ((*mpol)->mode == MPOL_BIND)
> +		if ((*mpol)->mode == MPOL_BIND ||
> +		    (*mpol)->mode == MPOL_PREFERRED_MANY)
>  			*nodemask = &(*mpol)->nodes;
>  	}
>  	return nid;
> 

Other than the one nit above,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
