Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B115EC7DB
	for <lists+linux-api@lfdr.de>; Tue, 27 Sep 2022 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiI0Peq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Sep 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiI0Peo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Sep 2022 11:34:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EBDC22
        for <linux-api@vger.kernel.org>; Tue, 27 Sep 2022 08:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+OU8mH0vK18mzlPQMBXyIKR2yi57adGARoQRPD+hWL46EYmvA8AddfWcz40zajHA01oYexXhzSV2CYKrEjNPmaMmMTo/jNT0s39nkxM0a+JeMKemWuigoPl4m1l3Xdf80w+8/IP7LNXOPcuBDt4haeLSnDpAIxXY1WCptPzktA9W/IastYJt/R/fiPSadqktMfnuZshP96wm8apIpiHK2mu2sSBl+V/virUkVXnRd+dEp34RRigvLgQ1o6Ui9kmiIIyISDjyOax+h+skO8u9q+fwWJwHIRE2NQrTezOcTfbU6fl3YDA+5BvTVRdBU1oZqRZJxGQvdhxtbTWAquLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JteX5M+FV40AGgl1M9DLEDHkl96qSerufGQeQMCxW84=;
 b=WvKWTvQPhGNyt9AUeMFLtJUVD/Ff+TyVjeeGoz+HbEp/gpaThIHDIJZSCaEqolHLckkn1V8u+FqylJmeGZjF0PdRpEgclN/kcgRUPTrOlPkbhVNEL5K6RzGOlJqMftWuf0SjIvGRlE/WH2QgAllHge7AVoy50HdYoyU/myPKEn2DLwsq8z37Kjuk9sWKAxvV2h4MKJFjS3VEDJMVdB/JDaOpgx9F1uTSvZYE/KEGywAo+tEIZnVxHrQ4GRrWOZe1Vz9J0V/fR6fYlfWWnQR/Y2/0EJCt31mrpkRP+wPYWP0zCs0sdIuw56EjQ31iFjtHRxYuZfjj0CGkcykzTytRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JteX5M+FV40AGgl1M9DLEDHkl96qSerufGQeQMCxW84=;
 b=F6ez0GTaWY2s4iZA1miKrknNeeRAlj95XF2nJudIgRKvP57iKZr+BHCMr2bF6lf+fXbqUg/DV9b3UhH8hYpDps71qJIRkIG1eMb5IoOMH3OH4bO4oqbXv+JvvkPMl7APLTLQD76TliI35tlwTMZJCMDycnUaxxJkbnjXTn9CMDolKq0k9l4yryH1Xabbu5FsPsIhssnWBUbpMdhaAyzKcW5RxW447j9GboJE8NGpZ+ZOPvSjrqAukgx1YjhTYuJLs7WJ+9KKBJa9GlVoZKcxaD3WyC3nm4FKg08I/HMfCY4T2BJLBectLuSYKR0BqE4Bz11BNN4ALDyIF9TAMz1NJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Tue, 27 Sep 2022 15:34:38 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6%8]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 15:34:38 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>
Subject: Re: [PATCH mm-unstable v4 05/10] selftests/vm: dedup THP helpers
Date:   Tue, 27 Sep 2022 11:34:35 -0400
X-Mailer: MailMate (1.14r5916)
Message-ID: <B6259986-56F7-4393-88F7-69DE839C53F2@nvidia.com>
In-Reply-To: <20220922224046.1143204-6-zokeefe@google.com>
References: <20220922224046.1143204-1-zokeefe@google.com>
 <20220922224046.1143204-6-zokeefe@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0AE2B72B-BD07-4D20-84DC-88A269F5D75E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR01CA0030.prod.exchangelabs.com (2603:10b6:208:71::43)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 337db2b3-ef89-4f99-4870-08daa09dc9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pqYBNGd4NBRWDKOhDlVbYrYcuVoQHnQjdd2PN6emrB0YKejWLvARQDQXqHFHxSh+EO1I7mp0IRYNrtbKHbJujrJ0xOSo98N+g8zHWFweFggl63XKmMyB8fs9KdkJvjPvyPTUaHsOCc1JEC7yFBujXIOrwC1xfAdFANhF8XiW3jjR7T1RM5u5dFOdzIYC2cHFAfpDvdt4NfPY7G9EkPGURzrdAPvT+paxxsNge77nQodKcOuXWVVKIavRT6RTlzyvW02JB4dptflvUtf5qLiMKnWkau5BgSXOBRklnIr4bI2dWplAWVja37ilHNHr3owv/fdQ0lsv5SiBjcxgnZg15EmBemgqdxqAn1vDFnrGT34gf+TbKwpwdngYDkCaPhH4sa0d0KkfBWBLy/e3a1r+wpEjvI/bJwy9yFclB16jFfgiapZIyyNALf6G9Y1pXcT/J3H28ml7VnprYCk0W6yFBxEcXZpq7v9ubcy53yRscyW1XsaZ6alC49qTxlPcBr16UFb1wNreh+FWnjapitX9f5cOkJ8UCW1Mq4cC2LbxH1Xem6+CAjlT0oAiLb5O1eEqB5siIIHb8f7QaLZxKr1NgiRNt3XswQyOa1GyLabnDTMCJtyRC0iv+ZPahAcLaDuX9HBtUY29dp/u61tAJSafeE4bQjgRREdKbJqGZSYBzYbWvK/hpNqixtHioYZ0el+0ESMC0zzZCOIX+px7u2BoHTmLr6VRmlPNuM6LKjuto/BE+5TkzD3Z0o6AzVTRpmgpiwWlQsPYo2ERaym6Au5nGpHSmyYcTppEfK8aiNR9I2PPtLG1L28komAUIL7MeNKiywLRBfbA5djhiS1bvpQ946ao382AwpSm7OZgT9eHuTvbEJ4uftUBrv8V4Qu2NZk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(966005)(86362001)(8676002)(66476007)(66556008)(38100700002)(478600001)(6506007)(53546011)(8936002)(66946007)(6486002)(33656002)(36756003)(41300700001)(5660300002)(316002)(6916009)(83380400001)(26005)(6512007)(54906003)(235185007)(7416002)(186003)(2906002)(4326008)(2616005)(6666004)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85JLf6oo35kO0Db7vPrIVrwdZ5sgj0oW6NxKEbAiWpnubNgWuPpd2MSu6O8M?=
 =?us-ascii?Q?QRX+1Zothd7/O3fP1WMB+zsbLqxliEI9815h6GGy74A+w+/T40b+Cj6clfiu?=
 =?us-ascii?Q?ZHUPOcbmhRh//Siii5FujgD3PqFoKk8M55246S4SBI6Y/o9qGuvubfHKZIl8?=
 =?us-ascii?Q?j9kohLS0yp3Tp+vzu7XMcEC2ovz+bgJh0MTZKzl5fArQtu19sm0bNMvFReuJ?=
 =?us-ascii?Q?BPj0sXRMZkkQFMnS+qMx1ov425cggM5q9737BDNkTBgpB4ixbmpVax1AB/jq?=
 =?us-ascii?Q?ihrUTLh+KbdBUbp4Txx8o3MumODmoB0qdHCIJmlkvOp8vguO53B2Uu9t6i6j?=
 =?us-ascii?Q?uS+WrcJDQEZXP90DY8XLmmu4mRe4tY+p4GjXfgLgj9hzasNSeRCeAlq4gZkM?=
 =?us-ascii?Q?y+iMEDsPcxcHdfZOZyv2BmQCniEkxNioO8TSXyPPU6QTPU6yIGs5+AwuHZux?=
 =?us-ascii?Q?fTPogwCsQ2XhvkZHmSZYuiHY2Lmvvx+hdhBCwvOch9KdH1109d7+sDAJxyRb?=
 =?us-ascii?Q?UVTI56jLoQLZ54ly7EjHqTtnPJt16GymqpPzno8jByu+1sD13V50O40IXcgQ?=
 =?us-ascii?Q?48CNqkldSH0nysMqawzsjhSeT0L6XTn9qJRD+iNEJZKPTHkOp4l0cksd0qZU?=
 =?us-ascii?Q?VDNga1Q95/Jw8SLi3FtfuMOHHnOd2Tv0hoDso+78+d7mjqCxMOZR5UeblI7+?=
 =?us-ascii?Q?ShrUzuQrl+hC0ZeSVhs/yRh8tcA9BPsHcE4Qvjo2eHi8gPYsW6vVi/AM2Dfa?=
 =?us-ascii?Q?7JFaNpe5jwGOPUb7Vl4kOU3baM/qagbZuladCG6e756GVmX6ROj1NZShfzKt?=
 =?us-ascii?Q?DbxTCfMOoArPMl97lu6qAXUnlAHEqB9/t8rt4NzVNxjdRDtEGKROFP03RCJK?=
 =?us-ascii?Q?SrkviiNDlNRcx1VFM701Zvrt2rmu3BEadVc8rQN6WGPG3W3XyVIEQ2fWzpx4?=
 =?us-ascii?Q?C+PZOaYU7Y9E0xgHnTKaRplnsrO35XW3xLQiivJGR28Nate7UanDZh472a68?=
 =?us-ascii?Q?qCzMmf9Ok/GbZKu9oUXeTTrQbxOJadIF0O9vxS+qTSG/jDvcHg8Kqd9ysCtu?=
 =?us-ascii?Q?zmRuRowrAaTf88sQRwhdawitej9fm80Oj8sW43ca8xJjMO4QtZLMxISdOMuC?=
 =?us-ascii?Q?bxcnT8es1PUNs/KWbt8L1+IRMz/jfGmbRfVB94bMGKg1yg8I+a+Cr/TjG8Ky?=
 =?us-ascii?Q?X3boLDr5dODJQOZKG4U60q61iYsSyPBpBvpt1Q361Rfg4jHBLDBWuTP/oDD+?=
 =?us-ascii?Q?V/tlXnuPB5GdNYzhcmS7thdIeTswj8PX+PN9a+NXFBG+YxRYDjfYFqShUOtc?=
 =?us-ascii?Q?saPNck9RqdNU+yiuKSizezILHg3IfIbDnW6QJ9nn6Nr96CCpU1SKTKARcjN6?=
 =?us-ascii?Q?YvXqaAF/KF5STZi522ZLf00hIIbdZc/qWXVhmTY9YWbk1YFFSOImEdkDuPsT?=
 =?us-ascii?Q?7jRSQ10s3G4vAJydobZ68pOmfaKWf/RZ3SS9P0drvH9EW8jkxb3QKb7xCod7?=
 =?us-ascii?Q?+qMVYHXQa2z04Q0qzb14zcJItsmuwCenfIthP1vk8uR7KmpHbDUlPhhbS2Dz?=
 =?us-ascii?Q?8HrgOLow5+R7m2qLdC/5PzFOFrCMS5kXh5nNOPWE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337db2b3-ef89-4f99-4870-08daa09dc9bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:34:38.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PnBXAy6q83ncPzLCVc+P5N/AnoHtIWXsntJknvKKXFM67PD2sPB75tfFgFqUVZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--=_MailMate_0AE2B72B-BD07-4D20-84DC-88A269F5D75E_=
Content-Type: text/plain

On 22 Sep 2022, at 18:40, Zach O'Keefe wrote:

> These files:
>
> tools/testing/selftests/vm/vm_util.c
> tools/testing/selftests/vm/khugepaged.c
>
> Both contain logic to:
>
> 1) Determine hugepage size on current system
> 2) Read /proc/self/smaps to determine number of THPs at an address
>
> Refactor selftests/vm/khugepaged.c to use the vm_util common helpers and
> add it as a build dependency.
>
> Since selftests/vm/khugepaged.c is the largest user of check_huge(),
> change the signature of check_huge() to match selftests/vm/khugepaged.c's
> useage: take an expected number of hugepages, and return a bool indicating
> if the correct number of hugepages were found.  Add a wrapper,
> check_huge_anon(), in anticipation of checking smaps for file and shmem
> hugepages.
>
> Update existing callsites to use the new pattern / function.
>
> Likewise, check_for_pattern() was duplicated, and it's a general enough
> helper to include in vm_util helpers as well.
>
> Link: https://lkml.kernel.org/r/20220907144521.3115321-6-zokeefe@google.com
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Chris Kennelly <ckennelly@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: James Houghton <jthoughton@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  tools/testing/selftests/vm/Makefile           |  1 +
>  tools/testing/selftests/vm/khugepaged.c       | 64 ++-----------------
>  tools/testing/selftests/vm/soft-dirty.c       |  2 +-
>  .../selftests/vm/split_huge_page_test.c       | 12 ++--
>  tools/testing/selftests/vm/vm_util.c          | 26 +++++---
>  tools/testing/selftests/vm/vm_util.h          |  3 +-
>  6 files changed, 32 insertions(+), 76 deletions(-)

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_0AE2B72B-BD07-4D20-84DC-88A269F5D75E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMzGAsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUUaUP/38rOhyEAmPShMKyOxr5yqLh20fO9cwevoWi
KgoLRFATmzQ19TgtInQoURn6562PmvFUda8fQbnS4x3KYWMcb6+StwcRWcQP8N83
AMqLdAR+NBMKwCNmY1TuR1mYAY4vLJl0S/zkzBfhTWKN9X25l1SLs4bMJuPUFo7B
vUpFr/XaRzwdKMa0Z6bBp/oj06CQzmb84XZX3yJ3mfsQmrer8ow3JWa9tEXwqNwL
MbcJ0gXQBvFJX/uoMUrARSTfR6Q42t6XchOn4qfQ3HA0nWJJdfR5htvr3d2Cep0s
u3pyOXoIPP4WQTkuyrQGgiWE5+cO1RpFD8n/R0qEIpKLoHArweZOCQP3VtQzz0Yo
XPHtPtXiGXPE+CvpZjPtUAGU1b2ogsShSIiVDlN9eZ5R6InS8jL2LFoqvgatao5X
9W06WzL8UKNq7GH9R0nYuQUj92DkKcObhBFdJ/QQV8RPfIcQRk/JssiDsxbw2b9K
n6s2IsRDnNOA2ZUgX7oNs4Go46VQdca6p/anigVTEwEggwHjAI6yn/Pq/IrDZMZj
NC+SafLa6tby3ZC4sdGgemUWRcT2kCZuueqrfnqbT/GYxQTQ59JmDDLmtpS8qP4k
CgQOILrlBVcC9cJNi70Li/tygARtwjWyiuT2a7EI8BqX11ma2uIbvDp343pNeify
7pOqMpwp
=+Q9i
-----END PGP SIGNATURE-----

--=_MailMate_0AE2B72B-BD07-4D20-84DC-88A269F5D75E_=--
