Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985E4464409
	for <lists+linux-api@lfdr.de>; Wed,  1 Dec 2021 01:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhLAAvo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Nov 2021 19:51:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61114 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345867AbhLAAvo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Nov 2021 19:51:44 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUNW0q9015148;
        Wed, 1 Dec 2021 00:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=sjpZuJzTIvBUG0ITPoo9Uy8a2KpQmOnrS3jLZpNzs0I=;
 b=wAiCtiU9PyXKYCGNLhG/hmvoRIsNY9kOVZLQa0WJM8i/OXC91DLmuPxBVYKL4dh/FCxe
 4pj3zugNh0plsf7kwvA3iOcoN4TY2/iUNd/23hK+Rz6wBqPsXckzhGB8//9QCxNIG4VK
 OoFKy2V5ZMO01JMa6htwCQuFPhrEVzVnJEgXoswLxnRSQ24DxMGgoVgI8xxhU+WFoQaH
 miQKlNgF8lwJE/ie5b+XCqndxTjrlsm8xmFftmUb6wo357FHyS31hDIyTPIOiFPpHMOG
 ff+Cz+sVY8fUFfZkGPePSK/3xtIJeWlvZS/vS16fx4TudIXHMvwfLAP5QOJe0t8PVruJ 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8ccye2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 00:48:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B10kJP4090550;
        Wed, 1 Dec 2021 00:48:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3cke4qrhrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 00:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9/forPmguRlI9tRiwmw6v5LeZ0L6CjmURTWyT6c0VNgwNecYJq6jlf1skak1Ke+h5xzjwi6sNASd58hCPF4/WTUPGysVpfPWEfGxgGAgEVHwmkQg4a/bTOgaDx66byhUSCzeE8Y2PnN7v+SprMl3nKdPgOpF6N51g8nzzoVtTvSd9gU1bW2U8niOqNDfyZxy22urSdNtq4368SCrXr040REZ7dhTZGdu8u5tVYmsqxh3BRp1sm5CzhENg4NI2NTM9W20wCR9gjP7M82eN+T61RvPYiTpEmOdOf65tfGxush3Cwvc1P2B6OnhZkP1isgi02OAwqv//WFIYJN7uV6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjpZuJzTIvBUG0ITPoo9Uy8a2KpQmOnrS3jLZpNzs0I=;
 b=C4N4k9BTY+F4ITlow6WuTIhAwwhqQVOp/xxFKfzUgqcNgDWYhldbNjjfnXjlu/4iAC5aDTT4DdDpCXazM2xH7IjEmrLs+/7D5gSDx1KyaCcU43YYEUg53dpj7rY7vyUaC7zD1M4K5DzEcH+1IfasZrPEQXo3T3996PtDP2v+UC5+MtIGH8oeX9nu2DZGfxPf8TLAptTx7rdSXwIVWLVM+vPojnxYyog0TiBZ1070XQEJFj0hikr+nRZUfiT0nMObJHNvULYMwxq8Bcow0quVOV9GRzPOP+SKi7VRwXN9A0kSau56MCorhGp573WtkLL2HhPmesFfLQI/sERHwoPnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjpZuJzTIvBUG0ITPoo9Uy8a2KpQmOnrS3jLZpNzs0I=;
 b=PnHhhprpHjnDJ+SuNLROwGYLjsa0DoUKkx0UTyev1XaV76AkU3WOk9TYzF/f9mPfvsuoBoFGebYqTLhpwrvNDL8KX8opQ2J3UvNcaaYvXIu5uTS+/cqAKZjdU8fyZ89o9McE4Oalunp0I0DaIQ/JLpmpTMos3hOYPFgK/BPoMmc=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SN6PR10MB3454.namprd10.prod.outlook.com (2603:10b6:805:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 00:48:02 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::288d:1c:fb77:ed0b]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::288d:1c:fb77:ed0b%7]) with mapi id 15.20.4755.011; Wed, 1 Dec 2021
 00:48:02 +0000
Date:   Tue, 30 Nov 2021 19:47:58 -0500
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
Message-ID: <20211201004758.boix3k76bjtz2p4u@oracle.com>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
X-ClientProxiedBy: BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::13) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
Received: from oracle.com (98.229.125.203) by BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 00:48:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d264b91-0f8d-4e92-203c-08d9b4643aba
X-MS-TrafficTypeDiagnostic: SN6PR10MB3454:
X-Microsoft-Antispam-PRVS: <SN6PR10MB3454556A21489AD1ED8893FBD9689@SN6PR10MB3454.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJB/KQHIxjyidUF4sf491qYY0AYH6HvsbeDQA8rTAPvKF2RwJid103pFxvL4CS8KVH4N9gjCSv+8kW+Cyb1kALajzJM/maRrPxXfmC6eRlwKMAq4mxjavtRHiyyZnbxlRQf5MVlKk0edRAqGkBS7jM5yfHndgbYrSmlBjOmcVNSbU+sgdKEWYSgmK9bUIwFUydhf06Njdn7A9XOjCSBCyqFULe3iFRZo61IAGKTAZbBX3BYKpbFtFdhrKNronqfZ45SLmQTGgGJuh/GxhtsJIIktU1tZs0Kb6WNh+1fjoILsyr/y137+IlJP956WcYvOSkg95NjyywJS6B3Cqnnf5RMhkoAoYoh5GrDoLjUE2ytN5cXNwYYK6SDG4DBAtQiHvaHOoEC1MehqZpakLF/yRZwshKqcQPFf2WH2QBckujh5fMdiALwCBxx4m8S/SccW82b1RbdGJVXMKyGuHY1Ro8zx8MI6QXGAGH/mzyEhvJx4QmgzEIedKJVPZMs76kdYhPVuAlb8BsVfhRCMi5pVzCZMIRyg5nsgreB9m9PKkSRh+gQhlLvWyb7HrAEyLZumtcyK89bzlqz3fs+XhwZcQqWV8tKnzAcrb37NiTxq28X8CpYODMyaY8RbWoo0S3DOfKONpEburVzPgEDgtlkFri3xxoJxKwZToS4vk+ywsXg+A5Z93PfEmsPurapLOBSg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(2906002)(38350700002)(8676002)(52116002)(6666004)(316002)(6916009)(2616005)(4744005)(38100700002)(86362001)(8936002)(186003)(54906003)(508600001)(1076003)(66476007)(83380400001)(4326008)(7416002)(66556008)(7696005)(66946007)(26005)(5660300002)(8886007)(956004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JFV69vud1ws0es/eADs6NeAenZLVJoheEs0A8qCekJcoAUmUX2UtRx+VmOl8?=
 =?us-ascii?Q?VIq+7yDLc8WaPZkRD8soIOnUR5BrnRBu3UJPbfiWxMwgttbC2snaVEmW+f5V?=
 =?us-ascii?Q?O/1b5yZM6ZvqWv4www28xQQLn3FhJLaJcxScAWYLvYGeLncGmswud2aUhH6Q?=
 =?us-ascii?Q?sseGr4jqfP8ZnEwM2SD9SgDc04E/GCQraig7rxknT/KqG8fvXQJAGQGx5+vW?=
 =?us-ascii?Q?uoszTIEEpeySVSVjBdeOxx3gDp7xi2Tqb6+bU7Ihx6f/EGIViLlj/tabiK5W?=
 =?us-ascii?Q?zDFZz54JsNmKDM79DtiSCSq57G3B0Xqll/RENO+XkMYFhWZ8SE2qyvsc9541?=
 =?us-ascii?Q?jjZBxWR8oq4uhrNDwvTqXsxgvQZEDfdSRYCYQmK4gMofJpdAJ8UEOLls9H27?=
 =?us-ascii?Q?rncbdM4zGTszWjniMj7E49MKtoSUAAxqNrAlG2KJli7LKQcQ3TjugRO5iDsN?=
 =?us-ascii?Q?pleAhd9VE+9xBOdS58ldjjZbX8rJcI1BZlh1/5HV18HntR1syqdU5Q+2fppR?=
 =?us-ascii?Q?ehBL2A8D5LYHtULQXiFkhO9tbrU88imixjF+H640SfmqIgamuRPXej0Unt73?=
 =?us-ascii?Q?QzFm6xZArL5UO2CnXBmjcRmbCI4OOibw0ddSMH0KDSkfgRFE/uMcglb9Axwk?=
 =?us-ascii?Q?hAfysDitr6zXhtwaGkBNWS3kI9JUI9Ro2Glw25Y41bjWRlU8lqEf4XJsJI6u?=
 =?us-ascii?Q?Han9z9stLDFK0NsX2DCvp7L+YLh9UTQCpJ07EUntlxMSbxPb266poKJEJopw?=
 =?us-ascii?Q?rmisX5og/Jnswxx7zXCzQGuiWDEXUYn6Bzdc5qoZ1EVVJ6/DSqn2xbTd7Izx?=
 =?us-ascii?Q?MzC/d82jn6cGTwL7yPgga9p5a479hvcri29hYhq7Vbe1/9MAb9bZR1FmjStv?=
 =?us-ascii?Q?zaWbjPCOrPhMyZwF12IvQvDUXIL89WiOlM+stYuYtorazyrPo0TR75cc7dtG?=
 =?us-ascii?Q?DUvzfQsA+k8NBawsVcnrRamUjYHBATvUOSSCPfI1hZRxcM3y/TtSjWgRNoYC?=
 =?us-ascii?Q?bFt/9ytFzFl6OM6+4avbETM5A/ob2BhdwzoNis3fyrc8vs2Ll0VTP0iy19xf?=
 =?us-ascii?Q?VTM4ma9Dc7x4GOahrhv9RlfgRuBRMMpFkaZ0KpaJOGy4iIBJyLJfwpuO/3sZ?=
 =?us-ascii?Q?k4NelQOc2zuFM1Z35nvWd92KtsUnmHCuuhJ1gkfl6wXat7VmQe4rzU7isNF+?=
 =?us-ascii?Q?KtlGw4y4n9O2mV2tZpeQ3yDZK9H6gFX0BRCyWxDN1BxjXEEgz1XgksVvSVfD?=
 =?us-ascii?Q?e2C7SAQ6hLp2UuXKp+zckt21u/PykkHYtVX2xRBbhWCtwYpGp6FGRLJFpEev?=
 =?us-ascii?Q?o+rw1XSrk9gCwaBYtu4FWMvDRAw4IaCa4KaIrdQMde/S8GX1SNERsr5nDqe9?=
 =?us-ascii?Q?ZXDGS8Ip3qpPxkGxFA4CpBBCAcYJXnuwuiY/+V/3cIT/nBnr+2CL6RcJhw3O?=
 =?us-ascii?Q?vs+CRqjMyrKbIfllnBbZGO0wTgqdbbF7obJf7W0PEB7LhF1iNudExmMXTTAk?=
 =?us-ascii?Q?UvEIMFXPspD5b+401uKgsmf6KX3iO6a/WfQUadow277u6cuPd5C7l0rzB/ae?=
 =?us-ascii?Q?EYHcccE+bq4XDytcvdSMtLwfsEtTM83fKvfN7aX0zszFwIH+Zh3+4+9fNUlR?=
 =?us-ascii?Q?PMllTv0Iv69jL2m/5Ow1dgmiPOvAYUf6OnWRq2ooBazdhxN3eaYKmt+MOcF8?=
 =?us-ascii?Q?9+SW0w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d264b91-0f8d-4e92-203c-08d9b4643aba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 00:48:02.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X5u0/ctO22V7t09qP7uQcPfTEtcGNwFFGSFR+0tXABLdPr48ZD8MXcUTvCW2fIp9ojXineqBp1QCO7lEAg+T9yj42DOfXvCGuB3ciVIkWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3454
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010002
X-Proofpoint-ORIG-GUID: H7pnQK80QsJAxUgb0wMNEEcconWa1BpA
X-Proofpoint-GUID: H7pnQK80QsJAxUgb0wMNEEcconWa1BpA
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 16, 2021 at 12:12:37PM +0530, Aneesh Kumar K.V wrote:
> sys_set_mempolicy_home_node((unsigned long)p, nr_pages * page_size,
> 				  home_node, 0);

What about sys_mbind_home_node so the name is better aligned with mbind,
since both operate on vma policy?  The syscall might or might not be
extended to task memory policy, but vma policy is what we're using this
for today.


> +SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
> +		unsigned long, home_node, unsigned long, flags)

mbind does untagged_addr(addr), why doesn't this need to do the same?
Seems like tagged addresses could be passed here too.


> +		/*
> +		 * Only update home node if there is an existing vma policy
> +		 */
> +		if (!new)
> +			continue;
> +		new->home_node = home_node;
> +		err = mbind_range(mm, vmstart, vmend, new);

I think you need an mpol_put(new) here since @new is dup'ed again during
mbind_range > vma_replace_policy.
