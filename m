Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0333D2776
	for <lists+linux-api@lfdr.de>; Thu, 22 Jul 2021 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhGVPkw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jul 2021 11:40:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52224 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGVPkv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Jul 2021 11:40:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16MGH4rQ014049;
        Thu, 22 Jul 2021 16:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ELBQr4bUgJfLwgs7bGgFQj6iEeZnYD+TADfS2YsuM7c=;
 b=paHzuw/JT84wsA2TzHlVIAT7Bk6sztdDWI10KSwiRJowanromZElh3nn8/WXE2fsDggZ
 64R0PLXVKCIf9iUfsioEqTrCD5YqFQV4pdCqNSWI5qtyhQulbmYEIlPNtd0T5qfIZWBy
 IkRpFTB6nsf5L5kRZLRmlfaU6ruV7J49mmO/LiXxwd61TAVvAeqeNx9P34t+NCyCqAij
 ERdU6Cwk1l02pYHmWntxIOP18oPvxo7Im//vwnYYtxPL5OHmJApv9jjqftks9nZKlini
 pMtGr4e3tRuq1Tuyq012jRb4KQ2Kp/VBeWscPZK4h/yuL/wHh7mzUVwtbDynxbRhBkVh sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ELBQr4bUgJfLwgs7bGgFQj6iEeZnYD+TADfS2YsuM7c=;
 b=KtvdXeb6RJ07ku6b/Kb7TxZpOYOm1CUix9dvD9GDwpGqrQIEzEdd/FJX08yoNTXh4AeF
 Ootxwd00l/gxmzUFm+MoNR+36Gt4js4g71PTfdNE07af22CusS85Upe0zunoPD1HVVqs
 1CVR4V7PWGeV7MvH/DpRRbUZFNyzpx4rzyA0uOvrUD5DCsa9/B2yHvKweHrVU4dRYWfc
 msXAG+T23HxqTXJJeHGs5abNV6pMiDFDIFl/7p10UzpiG5+t5AMK77eG9m07HIIDEx5q
 kEEAQtNtX+nhJBaxshF6m0uC8sp5wt+1+n+NxhFZ4NRSYt4p0ny1w18WEGRjd4IeQyiX Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ya578crh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 16:21:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16MGFRBt114242;
        Thu, 22 Jul 2021 16:21:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 39wunp7krx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 16:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jARz1kr9cF0Am4UCqH67df01E9R3S1sNVl8VCmD+/5MVF6UbYzac182HFTADMm9W9CM0pzpTf2VLBGhVBBYjN/rPEE8Kebv9jvdHHX3BJlzLKZkIGmDdE3QQgE8jOfyfRsvX0wMAqUn10XY2Okh+SnadXoS2Bs5xUGcOQKfwE6x44Pn168LoduKsHcc3LMic8mIZdwwvnEnlckdN1AuQ3GvI7i8JRTPDvzO5XscYbb0hxyrr1QmtOTGfPPqST6LggNIWKQ/+glYM8IQLF46aUEat5+ChCQCOJ9Ccn6kT3Ic1OQfwl0g1gAyWAziWy141IvfOd/zd3xw9DrU90eXwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELBQr4bUgJfLwgs7bGgFQj6iEeZnYD+TADfS2YsuM7c=;
 b=XXmwmvfm9s4LPDNqU3pcv3MkV17BncNje/hDvbbXEyOp2ddkz6rWVKlrQVNhfWGfoqnpLX6ERGDGoFy28RrxK/cWlsivT/2Q/X5kmtsEPiBKom+3TQjiH2k4kGrCOG7rNQFtUHeJSOz8NnHC2UECdFV5lebq3bCGfvQ1vRtwq7ijiMPPKTXH+57y8DNRVg6Ki2fIn8/XzXf1MGe7+QEufuMOJ3rFLwJjGXjJTD9qhUOfmuHUpYCoTr5vPaJYJ9idH/o8P3bgwZbiFbjmML1f8y5RhIF5yZwpfW9//2vaGm9rX8+zfyyiTAi45Ly2/J/QJFRxfSlHb7CMMLgUqPyTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELBQr4bUgJfLwgs7bGgFQj6iEeZnYD+TADfS2YsuM7c=;
 b=X6245i+bF6s4yc05Pmc1EYw2EYEnpqiQub+aniDFWkWJeZjFV7Lr9YY8/60DzwLrKHNPnCm387c5WnToECQpdTKvkseCvnaMJpfGhZZVqC3Xp637Jb2X8S3mGDurM200Yd4myn8Qv84Tt656ppwWpC4mm9dT7PegDT0qXcMYHIY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Thu, 22 Jul
 2021 16:21:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 16:21:03 +0000
Subject: Re: [PATCH v6 4/6] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
To:     Michal Hocko <mhocko@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-5-git-send-email-feng.tang@intel.com>
 <7cdf88d8-9eea-5547-ee77-7d46829bf2dd@oracle.com>
 <YPk9hTQ5KQCv7KFw@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1bf315a3-5953-93ac-7bab-ff1328ee46e1@oracle.com>
Date:   Thu, 22 Jul 2021 09:21:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YPk9hTQ5KQCv7KFw@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:300:ef::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR22CA0008.namprd22.prod.outlook.com (2603:10b6:300:ef::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 16:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eb6274b-f1c2-4723-6a91-08d94d2cb319
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5439DD5B02949A4270208AE1E2E49@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ox8iiqiwx2uSWe5Od4E9rslvqaN75oWVxxe6RLAQ3VeiOYX0ZQJVxhkwHFRxk4q7WVoSGtq92J88tNbwx1Z6ZGBWhC85GwweaXTqrqqUe9j0YbYrmyfpWn2hgy7sDRUO2IaAxQtFgIq1PWcuyBdM26Gb/vur8bKg96X5uEvYlLt2izMljBRNwgC38hWpSGmzQLv+0xon9bY6phgRhRz/hmzqrwTNi22oNUto5YVaaOSKP1Dl12AKtF0Jx/LFrGtt5ixer1F71FWLCWr3ijvyemNLWGgrc3lugikMOcbbrzrZFBFl0b93DBLSYF4XRF3ctQY6RCn3j3fbOYuB51qri3OcQui4/FChde+VSYzhFRhaUCE32/ciq1sxy5vfnmkjo4ptL7id5pjcMorjB5gzwJzyi4LrQYpXw9yWHViWZrukkI5F5yZWizbul52E+WwpcFk9Y7cNr3Hgtss0gDFZujwj8VggN66KRwmghmeJ/GgZ47/+EWpmfiX6CVtdlHWQ51Zo1+E8IngxWG6fIH26Qp8ObReLlK6Si/oFw6USsLmgZlqCHDEAFkBczP1Db5FG+p3J7W2fFMtRk3cwWKCWLeu0tlMZsdDEizYeaN0TSJ//1zMcbxft0S1iJ2rWvdX2Uq2o4nRnTxQFywHyGzbmltM6/um9WWbylzvDEv4bskhPLIUmtnNRCd9jsRhT3Lvd6zBILYAmZ+nbu1D6KAIwcFK/d7J1a5tdQPb4IRyZoM41CI8KWtMD09/hzECtw9T/wooeAXYKOQUCO5RZopmEVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(44832011)(31686004)(478600001)(4326008)(38100700002)(83380400001)(86362001)(66556008)(31696002)(66476007)(6486002)(66946007)(7416002)(6916009)(2616005)(956004)(4744005)(52116002)(316002)(54906003)(186003)(5660300002)(2906002)(8676002)(36756003)(38350700002)(26005)(53546011)(8936002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU54T0I5azA0UTlpVi9YZ2laeXVHbUx1ckFDN0Jidmxyb0hwbUhKYTBQZzh2?=
 =?utf-8?B?OTl4Z2hYSlJENmdtOFpRdTdYVXJVdTU1M3BrZXJKQXBnZVJWUmsybnlqeXVO?=
 =?utf-8?B?MTMya3o1RWxxYnRWRGFOVW5xaW95d2NGaEw4cGtNUHdnNUVSRk5yaE1OdnJG?=
 =?utf-8?B?RHZnSXJkQWhNWWc1M3Y2YmpZOGxFZlZIUDYrWm8wWHFxMWVCMENjektZWEZG?=
 =?utf-8?B?MEVVZFd6RFN5bXZzZDZrWWpkQVJkOXZ6VC9CRWQ4aFhFdDBDL0NxMEtJb0xO?=
 =?utf-8?B?bFlYdVBKZWhJMENmVnp1T3pNSHF6MEZpQ0tCMWVwRWFnNVltNjF1R3V1V1Fk?=
 =?utf-8?B?NktZNGdteHd5UkFjMm1rZDJXT2ltbFU0ZTgzZnlBSWZqMVdhNi9NdjQwdmhT?=
 =?utf-8?B?NTVWSVliYkxxRHUyZE1rYmNpWkZWRWZwUnBkZEZjYmZOODA4NkhQZzdjMk9h?=
 =?utf-8?B?ZnFYUURNSDdNRHpScFhUSU5iUkFOZFpOQ1p4bjVMZXdWb05oS3Q5RDVYTVcw?=
 =?utf-8?B?UjVFZjEwNm5Nc0N0eTQ3ZUUzTHcvWEpTeUtaK0NLbERGOUVFMUZaU2IvR0Zw?=
 =?utf-8?B?WFZ1TEMwM0JUR1lOSzltVjZiNW1nckZUOXd2a1VHRXhsa3ZTald6ZXAxb00v?=
 =?utf-8?B?OVk2M1pnZ1JHcGpSbnczb2hJVmkxTm1Kc1JLQW96amRTenRIc0hWM056WEJ6?=
 =?utf-8?B?ZzBKcUNmTnRLdHR2ckJhdWMzQnczQkptejFEdWwwRDZKWXdpVEM4RXJ0REN1?=
 =?utf-8?B?WjNEa3ZnY084RGpMc1YvYzhxcXVRdkZ3aGd5UTFFUksrbkU1TWtjN2pEb2JB?=
 =?utf-8?B?Zjk1WmUwTGNHZEM4a1B4SDNCa2IzQk9lMmFpTjZLbEV5RjJvR29kVjZDM0Z5?=
 =?utf-8?B?YTFnYjNobjZZUmxyYWlMVkNiZ28wWndVQTBIUzJobStpVWZFK2JKR3FRNk1h?=
 =?utf-8?B?Zy8wamd4WWd0ZURWUlp5WXdUb2ZLcG9IQlVSR0c5NUl5UkFUcnY1UlN4M2hu?=
 =?utf-8?B?RHJGSHJYOEtNSDJKS0hEL3dZS3Z6YTduR0hPREI3SVZEZytVOGtKMFF3cTRY?=
 =?utf-8?B?M3hrbTB4UXJTM3BBSUVlVldzVG41MzgrTUFzK0xCMk9vblZwVXROZXBYN0lQ?=
 =?utf-8?B?QjhONnhGcVB5TTlQNzRoSTYyLy8rSFVzeFdDbHV3MktpSTBPR3U4ZHVWclhK?=
 =?utf-8?B?azBRT0xHdjhZb253Q1JqNU03eEY5NUZEaXlySkFVRWFMaTVja3IzSXl5YjNz?=
 =?utf-8?B?ZDNwUjhIOFgwRXdoQ3A4c2pGSmd6NDdWRG4rWmk3aldGVDdRZDBzNEFlUm9p?=
 =?utf-8?B?Q3ZZNFhsbDRkZy92TEpTZlpRUG13Nm85RzErSlRnK081YlV0M2U5N0Faekll?=
 =?utf-8?B?WTJUcVMvVUo5am14TklqcHNTeGFWYVZUTXg3MUpKUUZyUDhEUEtJWlZZYzlh?=
 =?utf-8?B?YmpNVHU4VmJFZy8zSnY0Snd2bGdCQnJHdURSL3dmNVJQODJLK1V0aThlZ2Y2?=
 =?utf-8?B?WXBjVnFrZ0FQMUNqU0ZySDV5aFhrSFdienhORDFNWGI1SHNqUkUrVldrMlpB?=
 =?utf-8?B?MnZkNDE1RHROaThacENBNkZZbEswTFoxamxkck93NVFhQzQyN2VxSGp4czRv?=
 =?utf-8?B?WC9zVFkzSGJMTnNsK0dnK3ZyMjVKZ210emFMV2Yxbk5TNzBnV1NqK294VkdH?=
 =?utf-8?B?dDY1dEdBZVdWcjMzcUdRdjZ2L1FWckZheSs0SFVIdEFKRlFrRkt0OVRkb2Zt?=
 =?utf-8?Q?3r999PUJj3W7XupLalgjQKgTcK+CtFj5jPlWueK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb6274b-f1c2-4723-6a91-08d94d2cb319
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 16:21:03.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05BMn2dWamCXd4Rr40vmH+MGrMkBeESOoRMlOn1TepWxhTrC9abA+0sGhitsadojdk5aiTQnILWU7Qb4j8reqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10053 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220109
X-Proofpoint-GUID: N1Z_XrKAg04sFXQl_ZPmwbXDCvO-kjz1
X-Proofpoint-ORIG-GUID: N1Z_XrKAg04sFXQl_ZPmwbXDCvO-kjz1
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/22/21 2:42 AM, Michal Hocko wrote:
> On Wed 21-07-21 13:49:15, Mike Kravetz wrote:
>> On 7/12/21 1:09 AM, Feng Tang wrote:
> [...]
>>> +#ifdef CONFIG_NUMA
>>> +	if (mpol->mode == MPOL_PREFERRED_MANY) {
>>> +		gfp_t gfp = (gfp_mask | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM;
>>
>> I believe __GFP_NOWARN will be added later in alloc_buddy_huge_page, so
>> no need to add here?
> 
> The mask is manipulated here anyway and the __GFP_NOWARN is really
> telling that there is no need to report the failure for _this_
> allocation request. alloc_surplus_huge_page might alter that in whatever
> way in the future. So I would keep NOWARN here for the code clarity
> rather than rely on some implicit assumption down the path.

Makes sense.  Better to leave the __GFP_NOWARN here for clarity.

-- 
Mike Kravetz
