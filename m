Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7BDFE0FE
	for <lists+linux-api@lfdr.de>; Fri, 15 Nov 2019 16:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKOPQ3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Nov 2019 10:16:29 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:53410 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfKOPQ3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 Nov 2019 10:16:29 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 10:16:28 EST
X-EEMSG-check-017: 50107106|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,308,1569283200"; 
   d="scan'208";a="50107106"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Nov 2019 15:09:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573830562; x=1605366562;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RMViJYBDi7J5beytVgpU31xX1GEQlzjwCwrjAlauyyY=;
  b=bAbQI9kcOZetqxMV9K4Dg7Rnkw/uicYodk00Gb5CVAU13oVOxlSQe6RU
   /yCgL9KD+T2Ui6d1CLoYogtYU+JPPv01rjpfLUS66XYHHAti9kqgpGGVT
   9dFXZHjo/v2dMIhPbkvZ3s/SPqGVE6fLZbgnp8qM4goBwDN7K0en9VubF
   lWoa/KFQWjm9fbOxJdicfVwWqzz/fifjlhklM+O5UWXFnuTEHxFuEyDGb
   SZcdUBS1yNh2g3Eqnw1WTys8oPhNqgDXxAqc9MVL5C+SGbQwy4L/BgCi3
   Q2fLGFb1q+iLQlx0Nzko5Sm8XpkDqIL2srlbXXn/VZz/RmwtYtwdvMUFX
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,308,1569283200"; 
   d="scan'208";a="30153948"
IronPort-PHdr: =?us-ascii?q?9a23=3At7fe9hYTzFzWu8AFvTC/vdT/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps65bR7h7PlgxGXEQZ/co6odzbaP6Oa5AjFLvs/JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusQYgYZuJaQ8xg?=
 =?us-ascii?q?bUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwip?=
 =?us-ascii?q?oSvljDHi/xgkn2irOZdl449eSy7uTnY7HmqoedN49ylA7+LrwjltGwDOk3KA?=
 =?us-ascii?q?QDX3WX9f6i2LDs40H1WqhGguUzkqbDsZDaIcobprS+Aw9Qyosj8AuwDyy93d?=
 =?us-ascii?q?QEnXgIMFJFeBWdg4jvIFHBOur0Dfi4g1SyiDtr3ezJPqX9ApXRKXjOiKrucq?=
 =?us-ascii?q?x760FAzwozyctS551TCrEGL/LzXlH+uMbEAR8+Ngy+2/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUMKfTsV+O++IuLPCAa5UNuDb8MPUl+fHugmEjmVMHfqmmw4EXaHamEfRiOU?=
 =?us-ascii?q?mZZmDsgtgZG2cQogU+VPDqiEGFUTNLY3ayXqQ85iw0CY6/DofMWJqtgLqf0y?=
 =?us-ascii?q?e/BZBWeG9GBU6WEXvydIWLRe0MaCSMLc9liDAEUqKhS4A53xG0qAD606ZnLv?=
 =?us-ascii?q?bT+iAAsZLj09t16PPIlREy+jx0DtmS03uXQGxvkWMIQDg23K97oUNj0FuMza?=
 =?us-ascii?q?94g/lAH9xJ+/xJShs6NYLbz+FiDdDyXAHBc8yGSFahRdWmDjUxQcwrz9ASZE?=
 =?us-ascii?q?Z9Hs2ojgrf0CqyH78Vi7uLCYQy8qLbxHjxJ91wy3nB1KkmgFkmRtVAOXe6ia?=
 =?us-ascii?q?548gjZH5TJnFmBl6a2aaQc2zbA9HuCzWqLuUFYTRRwUb/fUnEffUbWotP55k?=
 =?us-ascii?q?TNT7+qF7srKBdOycmHKvgCVtq8oVxARfrncP/ZZ2uqkGa3AxvAkr+FaoHtf0?=
 =?us-ascii?q?0S2yLSDEVCmAcWqzLOMQk4GzfkqnrfJCJhGEipYE729+R67nShQQt8ywCMcl?=
 =?us-ascii?q?0k1Lev/BMRreKTRulV3b8eviol7TJuExL129XVBsGAqAttZqx0btQ671NKk2?=
 =?us-ascii?q?neskg1OJqjB69lgVEafkJ8uEa9+Q9wD9B7jcUyrH4shDF3IKac3UIJIyiUxr?=
 =?us-ascii?q?jsK7bXLS/05xnpZKnIjAKNmO2K87sCvaxr427ouxukQw97qCRq?=
X-IPAS-Result: =?us-ascii?q?A2DbAACgvs5d/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LIFBMiqEKY9bAQEBBoE2iWaRQwkBAQEBAQEBAQE0AQIBAYRAAoIjJ?=
 =?us-ascii?q?DgTAg4BAQEEAQEBAQEFAwEBbIUVLoI7KQGCbQEFIxVBEAsOCgICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCXz+CUyWvWIEyhU6DO4FIgQ4ojBUYeIEHgTiCNjU+hB+DNoJeBJZYR?=
 =?us-ascii?q?pcHgjSCN5MQBhuCPodoj2iOSJYihXcigVgrCAIYCCEPgydQERSRIY5dIwMwg?=
 =?us-ascii?q?QUBAY4ggj8BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Nov 2019 15:09:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAFF9KFM030008;
        Fri, 15 Nov 2019 10:09:20 -0500
Subject: Re: [PATCH 0/7] Harden userfaultfd
To:     Daniel Colascione <dancol@google.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, lokeshgidra@google.com,
        nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
References: <20191012191602.45649-1-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <77f984c6-0da2-8e6f-e3f4-9dab2bfb6c79@tycho.nsa.gov>
Date:   Fri, 15 Nov 2019 10:09:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/12/19 3:15 PM, Daniel Colascione wrote:
> Userfaultfd in unprivileged contexts could be potentially very
> useful. We'd like to harden userfaultfd to make such unprivileged use
> less risky. This patch series allows SELinux to manage userfaultfd
> file descriptors (via a new flag, for compatibility with existing
> code) and allows administrators to limit userfaultfd to servicing
> user-mode faults, increasing the difficulty of using userfaultfd in
> exploit chains invoking delaying kernel faults.
> 
> A new anon_inodes interface allows callers to opt into SELinux
> management of anonymous file objects. In this mode, anon_inodes
> creates new ephemeral inodes for anonymous file objects instead of
> reusing a singleton dummy inode. A new LSM hook gives security modules
> an opportunity to configure and veto these ephemeral inodes.
> 
> Existing anon_inodes users must opt into the new functionality.
> 
> Daniel Colascione (7):
>    Add a new flags-accepting interface for anonymous inodes
>    Add a concept of a "secure" anonymous file
>    Add a UFFD_SECURE flag to the userfaultfd API.
>    Teach SELinux about a new userfaultfd class
>    Let userfaultfd opt out of handling kernel-mode faults
>    Allow users to require UFFD_SECURE
>    Add a new sysctl for limiting userfaultfd to user mode faults
> 
>   Documentation/admin-guide/sysctl/vm.rst | 19 +++++-
>   fs/anon_inodes.c                        | 89 +++++++++++++++++--------
>   fs/userfaultfd.c                        | 47 +++++++++++--
>   include/linux/anon_inodes.h             | 27 ++++++--
>   include/linux/lsm_hooks.h               |  8 +++
>   include/linux/security.h                |  2 +
>   include/linux/userfaultfd_k.h           |  3 +
>   include/uapi/linux/userfaultfd.h        | 14 ++++
>   kernel/sysctl.c                         |  9 +++
>   security/security.c                     |  8 +++
>   security/selinux/hooks.c                | 68 +++++++++++++++++++
>   security/selinux/include/classmap.h     |  2 +
>   12 files changed, 256 insertions(+), 40 deletions(-)

Please, in the future, cc selinux@vger.kernel.org for patches that 
modify SELinux.


