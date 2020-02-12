Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9715ACF3
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 17:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBLQPP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 11:15:15 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:56433 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLQPP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 11:15:15 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 11:15:14 EST
X-EEMSG-check-017: 75880296|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="75880296"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 16:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581523684; x=1613059684;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uN7BWYfFlarg/9dMcbM62w2KFdcNjYRfT5/e+zn2Jl8=;
  b=DMYLzdmb4HwW0+tBLxDhG7v9zo0D++s9zEllwrcIKQaihpsxdvd5LLMr
   A8Qt1jNumZ3evwDrQtRv7dItPjCfBhRjZTYqm34MeRIPk2zcwo+mNDuMZ
   NmFVNmIqfeUf61cbyHfoA2/i1yo3e3/aNRTzhWEMjqgp+3ZlAF326bhLf
   b9ui0nrDdsnpOUTVv2GD/OhFuMVxU7Y/Gk8eAPZgDLFv77t8Z6f1hTxmU
   I7uxfyrykiGzzq+ZAf3jXTSYDI6x9po/ujddO0nNcreLc/bM8CyEhaK2k
   5PgnmJdDDdSNYjoCieKA3JmsgvhjvrtHgU6AxCfFssY4P2zqpnbiyHSqr
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39017286"
IronPort-PHdr: =?us-ascii?q?9a23=3ABTz/DhFDHCidnRVFgVggw51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o82ybnLW6fgltlLVR4KTs6sC17OK9f69Ejxdqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLt8QbgYRuJ6Uxxx?=
 =?us-ascii?q?DUvnZGZuNayH9nKl6Ugxvy/Nq78oR58yRXtfIh9spAXrv/cq8lU7FWDykoPn?=
 =?us-ascii?q?4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Xi?=
 =?us-ascii?q?mi77tuRRT1hioLKyI1/WfKgcFrkqlVvAyuqAB+w47MYYGaKvx+fr/GfdgHQW?=
 =?us-ascii?q?ZNR9tdWzBdDo+5aYYAAfABPeJFpIfjoVUAowa1CQ21CO/xzjJEg3n71rA43e?=
 =?us-ascii?q?s8CwHLxBEuEcwAsHrUr9v7OqkdXu+3w6bUwjvOdO9W1DXn5YTUbhwsr/OBUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02Np4z5ITyVzuQNvHad7+F9SOyvjnQoqwV1ojexxsYnl4?=
 =?us-ascii?q?7EhpkIxVDf7ih53IY0KsG4SE58e9KkFoBQuDuAO4t5RcMiXXhltSAnwbMFoZ?=
 =?us-ascii?q?62ZDUGxZsoyhLFa/GLbpKE7gzsWeqPOzt0mXRoc6+liRmo60iv0Oj8W9Gx0F?=
 =?us-ascii?q?ZNsyVKjMHBtmsI1xzP8siHTeZ9/lu51TaPyQ/T7uZELFgolaXBMZ4hw6Mwlo?=
 =?us-ascii?q?EJvUTCGC/2lkL2jLSIeUo44OSo9+Tmbanmpp+bLYN0jB3xMr8ylcClBOQ4Mw?=
 =?us-ascii?q?wOU3Ca+eS6yrLj4VX0TKhFg/A5iKXUsI3WKd4FqqO2HQNZyJsv5w66Dzi80d?=
 =?us-ascii?q?QYmXcHLEhCeBKCl4XpIEzBIOvjAPejg1WjjDdrx/fcMr3nGZXCNGLPkLjmfb?=
 =?us-ascii?q?Zj80Jc0hY8zchD55JIDbEMOO/8VVX3tNPECR85Nxe5w+ngCNV62YMeXXyADr?=
 =?us-ascii?q?WFP6PVtF+C/vgvLPWUZI8JpDb9LOAo6OL0gn8ih1AcfbKk3YALZ3C4BPtmPk?=
 =?us-ascii?q?uZYX7yjdcbCGsFohAxQPb2h12FVD5Zf2yyUL4k5jEnFIKmCp/ORpysgLyE2S?=
 =?us-ascii?q?e7A4dWZnpcBVGMCnroeIKEW/ADaCKWPMBtiCALVb+kS4U5zxGhqBf6y6Z7Lu?=
 =?us-ascii?q?rT4iAYs5Xj1MN15+DImhEy8jt0D8uZ026TVW17gmQIRzou1qBlvUN90kuD0b?=
 =?us-ascii?q?R/g/FAE9xT4fBJXxw1NZ7byOx6BNTyVRzbctiVT1amR82sASstQdIp398Of0?=
 =?us-ascii?q?F9Fs2mjhDE3CqlHaQVl7yEBJw1763cxWL+Kt1yy3bB06khgF0mTdVVOWK6ga?=
 =?us-ascii?q?5/8hDZB5TVnEWBi6aqaaMc0TbJ9GeCy2qOoU5ZXBdzUarbR3AfYFXZrdDi60?=
 =?us-ascii?q?PcQL+hF64nPhFCycGcMKtKbMPmjVFcSPfkItTebHq7m32sChaQ2rOMcI3qdn?=
 =?us-ascii?q?0Z3CXcDkgEjg8S8W+cOggmByesuHzeDDNwGlL1eU/s8vdxqGm9TkAqywGGdU?=
 =?us-ascii?q?ph16C6+hQNn/yTV+sT3q4YuCcmszh0B0iy39bXC9qGugpgc75RYc0y4FhZz2?=
 =?us-ascii?q?LVrQ99MYK6L6BkmFEedx57v0T01xV4Eo9Ai9QlrGs2zApuLqKVyFdBdzKe3Z?=
 =?us-ascii?q?DtNbzbM3Ly8w6zZK7LwFHe0cqW+6cW5PQ9rFXsoRypFk48/Hh8zdlV3GWT5o?=
 =?us-ascii?q?/QAAoRT53xSEA3+AZ+p73AZSk9/YzUhjVQNvyYuznD1tZhL+whww2rftBZPe?=
 =?us-ascii?q?vQGAb0GMoeL8epL+Mulh6iaRdSeKh5/bU5LoudfPuPxaCvMfwoyDmvlmlWyJ?=
 =?us-ascii?q?t20kuR+S5xUKvD1tAOxPTOjSWdUDKpt0usqsD6n8h/YDgWGmeugXz/CJV5er?=
 =?us-ascii?q?x5fYFND3ynZcKw2IMt1NbWR3dE+Qv7VBs908izdE/XNgas0A=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AmBAB3IkRe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuBGFUgEiqEFIkDhmUBAQEBAQEGgRIlgQGIb5FKCQEBAQEBAQEBAScQBAEBh?=
 =?us-ascii?q?EACgm04EwIQAQEBBQEBAQEBBQMBAWyFQ0IBEAGBZykBgwIBBSMVQRALDgoCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgmM/AYJWJat6gTKFSoNKgT6BDioBjD15gQeBEScMA4IoN?=
 =?us-ascii?q?T6EI4M4gl4EjWmCM4cpRpdrgkSCT4R+jn4GHJsVjmiXLYYRIoFYKwgCGAghD?=
 =?us-ascii?q?zuCbAlHGA2OJI5dIwMwDYMAjBKCQgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 16:08:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CG75qt091651;
        Wed, 12 Feb 2020 11:07:05 -0500
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
To:     Daniel Colascione <dancol@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tim Murray <timmurray@google.com>, Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
References: <20200211225547.235083-1-dancol@google.com>
 <9ae20f6e-c5c0-4fd7-5b61-77218d19480b@schaufler-ca.com>
 <CAKOZueuh2MR4UKi60-GVgPkXjncHx8J=mTTjRquB82CfS7DxBA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <245a7c82-93f6-1e1d-9250-499e00972f10@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 11:09:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKOZueuh2MR4UKi60-GVgPkXjncHx8J=mTTjRquB82CfS7DxBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/11/20 6:27 PM, Daniel Colascione wrote:
> On Tue, Feb 11, 2020 at 3:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>> On 2/11/2020 2:55 PM, Daniel Colascione wrote:
>>> Userfaultfd in unprivileged contexts could be potentially very
>>> useful. We'd like to harden userfaultfd to make such unprivileged use
>>> less risky. This patch series allows SELinux to manage userfaultfd
>>> file descriptors and allows administrators to limit userfaultfd to
>>> servicing user-mode faults, increasing the difficulty of using
>>> userfaultfd in exploit chains invoking delaying kernel faults.
>>>
>>> A new anon_inodes interface allows callers to opt into SELinux
>>> management of anonymous file objects. In this mode, anon_inodes
>>> creates new ephemeral inodes for anonymous file objects instead of
>>> reusing a singleton dummy inode. A new LSM hook gives security modules
>>> an opportunity to configure and veto these ephemeral inodes.
>>>
>>> Existing anon_inodes users must opt into the new functionality.
>>>
>>> Daniel Colascione (6):
>>>    Add a new flags-accepting interface for anonymous inodes
>>>    Add a concept of a "secure" anonymous file
>>>    Teach SELinux about a new userfaultfd class
>>>    Wire UFFD up to SELinux
>>>    Let userfaultfd opt out of handling kernel-mode faults
>>>    Add a new sysctl for limiting userfaultfd to user mode faults
>>
>> This must be posted to the linux Security Module list
>> <linux-security-module@vger.kernel.org>
> 
> Added. I thought selinux@ was sufficient.

scripts/get_maintainer.pl can be helpful in identifying relevant lists 
and maintainers for each patch.  I don't use its output blindly as it 
tends to over-approximate but since your patches span the VFS, LSM 
framework, and selinux, you do need to include relevant 
maintainers/lists for each.
