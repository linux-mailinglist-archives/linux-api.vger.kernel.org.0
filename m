Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7973E492
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfD2OWD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 10:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfD2OWD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 29 Apr 2019 10:22:03 -0400
Received: from linux-8ccs (ip5f5ade6f.dynamic.kabel-deutschland.de [95.90.222.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E1B20673;
        Mon, 29 Apr 2019 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556547722;
        bh=iQv7qdfNE2ZTy8sIWEeqO2sCGSXIkTfD+az4PXbR/KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlVpTOyE8ff5uwR+X2Fo9yxipvxr6BB0tD7ZTU0xIYIAgeIL+iSusOHylbN/Ip0aW
         8J9D/REnUqe5kGNK9WupgYLl+L2THYwe7sYigaRdw8UIqTEdEEkIEZus2n70MrsGoz
         GhiSIrOIjTlivm54pxLKsEVOIUHW8frEYUntptoo=
Date:   Mon, 29 Apr 2019 16:21:56 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH v3] moduleparam: Save information about built-in modules
 in separate file
Message-ID: <20190429142156.GA31567@linux-8ccs>
References: <20190429090854.GU9023@dhcp129-178.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190429090854.GU9023@dhcp129-178.brq.redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+++ Alexey Gladkov [29/04/19 11:08 +0200]:
>Problem:
>
>When a kernel module is compiled as a separate module, some important
>information about the kernel module is available via .modinfo section of
>the module.  In contrast, when the kernel module is compiled into the
>kernel, that information is not available.
>
>Information about built-in modules is necessary in the following cases:
>
>1. When it is necessary to find out what additional parameters can be
>passed to the kernel at boot time.
>
>2. When you need to know which module names and their aliases are in
>the kernel. This is very useful for creating an initrd image.
>
>Proposal:
>
>The proposed patch does not remove .modinfo section with module
>information from the vmlinux at the build time and saves it into a
>separate file after kernel linking. So, the kernel does not increase in
>size and no additional information remains in it. Information is stored
>in the same format as in the separate modules (null-terminated string
>array). Because the .modinfo section is already exported with a separate
>modules, we are not creating a new API.
>
>It can be easily read in the userspace:
>
>$ tr '\0' '\n' < kernel.builtin

s/kernel.builtin/modules.builtin.modinfo/

Otherwise, for module.h and moduleparam.h:

Acked-by: Jessica Yu <jeyu@kernel.org>

And it would be great if Lucas can confirm if the file format and name
would be OK for kmod.

Thanks!

Jessica

