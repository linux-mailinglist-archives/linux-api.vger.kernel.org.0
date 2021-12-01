Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85434652B0
	for <lists+linux-api@lfdr.de>; Wed,  1 Dec 2021 17:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhLAQ0p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Dec 2021 11:26:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26388 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350209AbhLAQ0m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Dec 2021 11:26:42 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Fd0Nt023661;
        Wed, 1 Dec 2021 16:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xzUlpPefr9Y+A5TmcJFdTBdISNt7K6LKCXx4c+d/K7M=;
 b=0AALZbYDhoC49lFrR3hfKTEr/wAKNn80tk/5RvjjxRLINa6p0bHE84i1vHe4O/kX7Y+6
 F9uIDUNmSg/y90YWG/bUkq2JueWTtxRIYWRS4VbVIMp2upMmwYt3+Uhak28oS83UGehG
 hOGFjwWt/940OUHOJS1oLbZ0Q2YDIBwsgKxokUHtD4hw3m8W8mrHoug1qnarP4Fm6XNY
 03zXfmp9i8k0Y6jCjELGGl56P4lQsp04ZE7lp1eDhz7Fds8l9IN+akj47yXQgb8Zhpij
 FLhowjDWRsULqLULamjjTJfKSqyWe4VbkeEA75llsd4VR07EQeusGeBBikOKzjP2wJl7 wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gkh91q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:23:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FJv9m134916;
        Wed, 1 Dec 2021 16:22:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 3ck9t23fvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIFpa1s+uTz5BjGkJ35YRbW3swJIsnDuWq1VbhF6kOoTa7ymQ1pKPl9nl0YFzFeD9SLywT59a2x73qF56GcmqW5NR08ZR7+2kCDNkKhA4uXOhHJANMHtu0rX82HMcx7uFbEiZOFkswKORMypN2DLskdaJK3sYKv6yLg1j56CxcaE+TiYhcQAXbNS1y6QErOtccCvr2KWlvrdYvkEAroiYDstFpM9NMf8btwBjAsssJ7ux7YTbJESULJvHEuWsi0yjjAfY/7Dwul/tv7vLEqTlT+k33MIwjn5l7ZTo7eWj1ZcNMdIl0/Bd1NTw8hUxncXGc9HW0kYHmp8L373uLVMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzUlpPefr9Y+A5TmcJFdTBdISNt7K6LKCXx4c+d/K7M=;
 b=HJWjngsNrWk04L49P+r0MEQdkr8TePXpKHQKvoAeztVrYYtC3mpsbGD1bQRlJuXT2izAgdQJLxUXFt6YV1rD8kwxHUobSWY77cBvyQHp+hyQewAFTZE5DC7ljY0LTp9f0BSJ3icHaTv0RNm2uwVqcduosRyqelsxCKLgCFHGctebELgm8riY9KhrJK1Hr/CV5oi51kdd9Z0SorhnAdwAY/rQOvopmdV+nrXEBF1yoQD32Wqz4e0QfmnKu3LE95BkNdY5g3+Nhb1JQrDpvZpoY0H4Yhmc/B6qYaObd50jXFgUZh0V4gdr7hXhHULh4amgjQKeW9VGBiaNFQjXxp3UvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzUlpPefr9Y+A5TmcJFdTBdISNt7K6LKCXx4c+d/K7M=;
 b=vRU/RNS5oosZ4RdLcUgNauc8kKAfzmGMOqYL8aB63qec2t/js4LXGBKxcbeW3Pp+Y5KijXKdsuAaSlx0egGsQWxD+R+TuMIZNZ+CY+nl44lLIzjufwmph0s5VEVL0c1/IXB0uKAWFzmcXEnV0MglljVoXzrAQa/FWDt1R/QGLGk=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SN4PR10MB5639.namprd10.prod.outlook.com (2603:10b6:806:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 16:22:51 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::288d:1c:fb77:ed0b]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::288d:1c:fb77:ed0b%7]) with mapi id 15.20.4755.011; Wed, 1 Dec 2021
 16:22:51 +0000
Date:   Wed, 1 Dec 2021 11:22:47 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Message-ID: <20211201162247.3cxpeyzbb2kknujm@oracle.com>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <20211201004758.boix3k76bjtz2p4u@oracle.com>
 <87tufsc0lp.fsf@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tufsc0lp.fsf@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0354.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::29) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
Received: from oracle.com (98.229.125.203) by BL1PR13CA0354.namprd13.prod.outlook.com (2603:10b6:208:2c6::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.8 via Frontend Transport; Wed, 1 Dec 2021 16:22:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42069715-f8dc-41fd-3053-08d9b4e6d25d
X-MS-TrafficTypeDiagnostic: SN4PR10MB5639:
X-Microsoft-Antispam-PRVS: <SN4PR10MB563907E3444C7EA44E1EE403D9689@SN4PR10MB5639.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQ+2DHYXir+ADNleTH/8yQmC3hA/1PMcMloC58YBYjb+mE/jm2s2FhIszDlFMcJBovm6YEKcDmbMwNPF97rmVz+PTXYxvyfF65E3o61mreYc3bk/NXXAUnsK7f0K8BbiAk34JPN00JzWFwnjTPig88UL5kACMtK61ICToLukjrNv/YfAvaOxy7/lIpwPvOvZ/SghXxW/Pn82VrgDRSGiNVkn/dI0Wrzt0E0dGioq+gpUciVfaBwRh10z6gKKUvdy38Q3KGFZKm6ggK98xYM2SEFZTxHufeli8Lxx/s9KCdN9+GmSl/MpRVqVgmkrN3Y2nU+BA3nEkkIlG7DEOvTyVa964hNvknsIIpusCR6CMhnUj1WZ8qBzUgoOG9ZKbJVgWaE4S551cS5H1HQ6hDGQG1lzKnnc1xI1RTTpWYbZKNIFKZPZWg9xuIS3Ty4ltnSVA1iglwGZL5/UA6+dnWGoo0UKdFBczI8qmvh8P1iAadrM8I46y7F0MVd2/KlVKgY7pvCE3Tw2GVq17ixGLByydBqbweqXr3E2LgLTSWf4YqWx4r8gvY+UW40gD+HKChKFzGV4E4WP+G/Udgca8vD2525RboN9n3pyyUU2+mP+Eif/ZZmqkazPCsVYNaDwnmwodiclWEwjRtXrsB2A8/Q3mZ1XJ40G+Ji4A/fQLobFCmmr3OBXxlR9dS+zJ+pzAwoKAdM29VHE+BZOUCip71GnbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(26005)(2616005)(186003)(6916009)(54906003)(38350700002)(316002)(956004)(38100700002)(2906002)(66476007)(8676002)(55016003)(8936002)(4744005)(508600001)(86362001)(7416002)(66946007)(6666004)(52116002)(7696005)(66556008)(1076003)(4326008)(36756003)(8886007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eLrYDoDEjeDiOAtIsL/oxdcjTnCQn60s6FEEz1uiCrnjBEktZTXG1KmwOnEa?=
 =?us-ascii?Q?3c5yEp1rg4uCOpAoRKOaSlbdNLYbYJFOv5JprQKs7SAZ7jja7l12hOAPjcaj?=
 =?us-ascii?Q?KlrsECqI6D1Bstz8O20XT0/0c1DAuernyuNrUyGRoXKZcrA89Lg4cY/9mEv7?=
 =?us-ascii?Q?u0c7JjUgi8CGzGJ2AhrBPNV75DvmjV8yyhIXuoF2/ludzb18NyHM4CZAfg4b?=
 =?us-ascii?Q?AdqRtv5WLN5a3srbshC+QlUGdUGFHOtp6cX/FGhKV/sIoH+Zb6jFEJgXrWyR?=
 =?us-ascii?Q?vsxX8W+HnrIGg0m8sXd1WwcAYojPJiBCbM94hmc2euHnQcNpgbBJRVLO2KHZ?=
 =?us-ascii?Q?6GjiPQztDbWp1LwgJ7XMx3mZgGMYWZcHG1LhnxxJsog+z0rbEyLOmWGeQwCt?=
 =?us-ascii?Q?TJhF1cyFgmieMOsL2+RAOWENZyDEve9xKXAQNkgdr4sljjkFIWGYoH3gMTlp?=
 =?us-ascii?Q?5MtYj9FyrgNf3d8VaAa7FweZ/VOZefmoepVwAGYAqEcot5ajdB5Pr5hvPYMs?=
 =?us-ascii?Q?saSXLx8PTcmqXCwRoFOzWvLhSsyKVH7rdxY4OqoCZLTzZVzj9+rzKfemY2AE?=
 =?us-ascii?Q?4lRljUzfRWB1epWcQF8QlN56UJf2WOqZ96a4y42XDielMgO+6DtcYN/iOBTi?=
 =?us-ascii?Q?kOHJM7lqjIsjbzJB+FuAdCVaglZoVjiUwNhZZHAdIIb+R2k6UzhU3melgYdZ?=
 =?us-ascii?Q?nXoXPk6s5V1KBF3XsWQZdTJsXBnOWUALw6jhQ02avMpO9jCQR8z08yZUKM39?=
 =?us-ascii?Q?e0QquGsjj9eJNxn+GHHJdRMRo3TPsKXQwmKPMly2lTVKkRpq49nrO+J2AIUZ?=
 =?us-ascii?Q?3Nl6EwgF65GINV2/XiEl1KpICjcbillfJoNMt8NmY+JG+nPSIre0OyPLwgs4?=
 =?us-ascii?Q?IIJ1CJKjy7XnNuZQ3osCh23uI+NrnST98pbvb+2U+WbovEfH3LSzmG4yxOFn?=
 =?us-ascii?Q?2cDzjDrX64x6g9N5dXLEt79l6Gu3hzjp8pGHBaRFaGSKlwMEj6ZN/wJxlz/n?=
 =?us-ascii?Q?/pYyxT7BFB7y1dXlPLSqr0vWr7cE8x/jq28HZqgoE2bAF4Z3qbE8+qlf49GV?=
 =?us-ascii?Q?u8SiTCCPPmmW1eu/Z9DpzwBzyxhs+WqvznN49SVW35yhpbsGhXiwK4uLduY8?=
 =?us-ascii?Q?sFZxixRcDu6m4llBGTBzMXQINCC6By4AdeU24eo+l/jDLBJLohrz8dyIxLQX?=
 =?us-ascii?Q?pEuKwzKxMzCCjyF+kQx6AxaeXoLjbjYxaCe014mv/J//NkJjefOBoS4SxsjO?=
 =?us-ascii?Q?4fNuQHDHb9TCtkKqiClrHjF9jrK0luVwAqEe9u0f3PejyHED9yKpUO291kz5?=
 =?us-ascii?Q?UMMdlcRqL5H3IVCR9HS1Rf0KPCdteXHuooLDU9kW59qFGUwe1ZmAjJj8VaOK?=
 =?us-ascii?Q?X4ockLwFIksqMshk5kcmhWlbsQ2moxfOorCtg7+iTL2b6tMBzKvvfEdN0eoE?=
 =?us-ascii?Q?6tWRMYwpo7f6IWV6KpHNic9Ug+0XRnXhWdThk0T2op9JPe8khYWEIG2yIdSl?=
 =?us-ascii?Q?1yuisQg78HK0mU6Wkeq56mov+Xfta++dZfitpagVVY4eiQKWW47TC3ZsDa78?=
 =?us-ascii?Q?MySAeIz5LcmQcZ+nkSASVIXyTgt1176XVytFm7WDquNTTxDvxt9zm4j7eXIc?=
 =?us-ascii?Q?v1FPu8E5I7i7ScznFWXKdsch/9Eh19RhiImcu0fS0BIWOYf85NXZ2uMxaMqL?=
 =?us-ascii?Q?x7oGyQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42069715-f8dc-41fd-3053-08d9b4e6d25d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 16:22:51.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUIumce33RVpzCS4bE9Pon99PQ+7o/aDZ/2q5gj7bxcsO69SZ0/b7MsOgPHRI1CV21KvhCdBfyoCaikevWaFHSO3xduzjsqsOd6Bpu7ZEr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5639
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010087
X-Proofpoint-ORIG-GUID: 8sq0vZj7s3vez3wo-VhBoOwzI4yjCuwe
X-Proofpoint-GUID: 8sq0vZj7s3vez3wo-VhBoOwzI4yjCuwe
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 01, 2021 at 11:45:14AM +0530, Aneesh Kumar K.V wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> 
> > On Tue, Nov 16, 2021 at 12:12:37PM +0530, Aneesh Kumar K.V wrote:
> >> sys_set_mempolicy_home_node((unsigned long)p, nr_pages * page_size,
> >> 				  home_node, 0);
> >
> > What about sys_mbind_home_node so the name is better aligned with mbind,
> > since both operate on vma policy?  The syscall might or might not be
> > extended to task memory policy, but vma policy is what we're using this
> > for today.
> 
> I used the name set_mempolicy_home_node, because we are setting the home
> for a memory policy. I find the term mbind confusing. 

Fair enough.  Forgive me for starting in on naming :-)
