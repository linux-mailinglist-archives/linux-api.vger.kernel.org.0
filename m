Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854FB15ADC5
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 17:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgBLQzo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 11:55:44 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:53178 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgBLQzo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 11:55:44 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 11:55:43 EST
X-EEMSG-check-017: 58160238|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="58160238"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 16:48:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581526105; x=1613062105;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=tqJba1TdlNSFWy2p2EBVa0SyOhsGODwQkBMGLBp66CM=;
  b=KhSnZJBjgqMsFqms/GGNAXk5CjxelVYRSi6lQjtqTquHfaRw8XXqkz12
   RmTBMJDsNjB63A84n1HFKiRLShYlyyOOIRAWhY7sl6tRxzbrJ1YunfesC
   wOlKJYa2n85dCgWz8J/GHhleJe4YZdtobQO7EHLYNP/m4V5Asqj8RS9ll
   UqkgNShs75V8qPjFPEgNkNfHs4rrHiCt/fspgRm3aE8PEAP6yPYx41d7G
   BInlH2yPYfWFUC0s2bU0dQo+BrFM21pOy3kJg1KpPlTMp9O47oyd3OUpl
   KXDFkB1LBKycp4y/OQTMUF3ZNIv5IhAasNR47c0cnp9Z0gKJamjzQdF+L
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39020809"
IronPort-PHdr: =?us-ascii?q?9a23=3AJ8zYPhEYsKZP5QIGOVe3Xp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pMS9bnLW6fgltlLVR4KTs6sC17OK9f69Ej1bqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLt8QbgYRuJ6I/xx?=
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
 =?us-ascii?q?WFP6PVtF+C/vgvLPWUZI8JpDb9LOAo5+LvjX88nF8dYLOp3YENZ3G4BflmLE?=
 =?us-ascii?q?KZYX3jgtcFD2gGpBYxTOvviFeaSz5ce26yX74g5jE8EI+mC4DDRputgLGa0y?=
 =?us-ascii?q?e7GZpWZm9CCl+SC3vna4KEW/IUYiKIPsBhiiAEVaSmS4I50xGusgz6xqFoLu?=
 =?us-ascii?q?rT/S0Yupbj28Zv6+LPkhEy8CR+D96B3GGVU2F0gmQISicy3KB4okxy1EyD0a?=
 =?us-ascii?q?h3g/xZCNNT/elGXxw1NZ7byOx6BNTyVRzbctiVT1amR82sASstQdIp398Of0?=
 =?us-ascii?q?F9Fs2mjhDC2SqqHrAUm6WIBJMq6KLc2Wb+J8JmxnbY26kukUMmTtFMNWK4nK?=
 =?us-ascii?q?5/8RbcB4rTn0WejaaqerwW3DTR+2eb0WqOoEZYXRZ0UaXEW3Afe0TXoc3j6U?=
 =?us-ascii?q?PaTr+jEqonMgRfxs6YMKdKacPmjU9ARPj9PNTSeWWxm32/BRyQ3LODcJLqe3?=
 =?us-ascii?q?kB3CXaEEUEiB4c/XKHNQg4GyegrHnTDCJhFV3xeUPg6+p+p22hTk8y0Q6Ka1?=
 =?us-ascii?q?dt172v+h4a1rSgTKY/17QFtSNpgDJwFU223tXQBpLUqwNnd6JYSdw651hD2C?=
 =?us-ascii?q?TSsAkretS8LqVnm0QEehVfsETp2BF6TI5HlIxiqnQxzCJ9LqWX1F4HfDSdmd?=
 =?us-ascii?q?j2PL7/JW718xSiLaXR3xWW1NGV97wP5/U0sVzLswauGU4vtX5g1p0d13qa+4?=
 =?us-ascii?q?WPDwcIV5/1elg4+gI8pLzAZCQ5oYTO2jkkNaiyry+H0sooLPUqxwzmfNpFNq?=
 =?us-ascii?q?6AUgjoHIlSHMWqKeo3i3C3YR8eeuNf7qg5O4WhbfTV9rSsObNbgD++jWlBqL?=
 =?us-ascii?q?t420aI+js0HvXExL4Z0vqY2U2BTD66g1C/5JOk0btYbC0fSzLsgRPvA5RcM+?=
 =?us-ascii?q?grJ9cG?=
X-IPAS-Result: =?us-ascii?q?A2BcBADfK0Re/wHyM5BlHQEBAQkBEQUFAYF7gX2BbSASK?=
 =?us-ascii?q?oQUiQOGZQEBAQEBAQaBEiWJcJBzA1QJAQEBAQEBAQEBNwQBAYRAAoJtOBMCE?=
 =?us-ascii?q?AEBAQUBAQEBAQUDAQFshUOCOykBgwIBBSMVUQsOCgICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CVyWsEIEyhUqDOoE+gQ4qiDCEDnmBB4E4DAOCKDU+hCODOII8IgSWYWRGl?=
 =?us-ascii?q?2uCRIJPk3wGHIJIiBIFkDaOaJ0+IjeBISsIAhgIIQ+DJ1AYDZ0BIwMwjx+CQ?=
 =?us-ascii?q?gEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 16:48:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CGlOZO118436;
        Wed, 12 Feb 2020 11:47:24 -0500
Subject: Re: [PATCH v2 2/6] Add a concept of a "secure" anonymous file
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        nosh@google.com, nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
References: <20200211225547.235083-1-dancol@google.com>
 <20200211225547.235083-3-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6c24ec53-1839-832c-cbfb-8b10b413e7db@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 11:49:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211225547.235083-3-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/11/20 5:55 PM, Daniel Colascione wrote:
> A secure anonymous file is one we hooked up to its own inode (as
> opposed to the shared inode we use for non-secure anonymous files). A
> new selinux hook gives security modules a chance to initialize, label,
> and veto the creation of these secure anonymous files. Security
> modules had limit ability to interact with non-secure anonymous files
> due to all of these files sharing a single inode.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>

(please add linux-fsdevel, viro, linux-security-module, 
jmorris@namei.org, serge@hallyn.com to cc on future versions of this 
patch since it is a VFS and a LSM change)

> --- > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf194fb7..ba208ce5711d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -215,6 +215,10 @@
>    *	Returns 0 if @name and @value have been successfully set,
>    *	-EOPNOTSUPP if no security attribute is needed, or
>    *	-ENOMEM on memory allocation failure.
> + * @inode_init_security_anon:
> + *      Set up a secure anonymous inode.
> + *	Returns 0 on success. Returns -EPERM if	the security module denies
> + *	the creation of this inode.

Please document the parameters for the hook as well.
