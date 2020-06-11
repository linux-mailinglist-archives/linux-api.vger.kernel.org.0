Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49F51F5F5B
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2020 03:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgFKBBS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Jun 2020 21:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFKBBR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Jun 2020 21:01:17 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD1CC08C5C1
        for <linux-api@vger.kernel.org>; Wed, 10 Jun 2020 18:01:17 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jjBal-006jnx-Lv; Thu, 11 Jun 2020 01:01:15 +0000
Date:   Thu, 11 Jun 2020 02:01:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-api@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] unexport linux/elfcore.h
Message-ID: <20200611010115.GZ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

	In include/uapi/linux/elfcore.h we have
...
#include <linux/elf.h>
...
struct elf_prstatus
{
...
        elf_gregset_t pr_reg;   /* GP registers */

and that ends up in glibc /usr/include/linux/elfcore.h.  What
does *not* end up in exported headers is
	1) include of asm/elf.h from linux/elf.h - asm/elf.h
is not exported at all and linux/elf.h is our uapi/linux/elf.h,
which doesn't include asm/elf.h at all
	2) and definitions of elf_gregset_t whatsoever.

Now, glibc (as well as other libc variants) does contain
such definition - in /usr/include/sys/procfs.h.  Along with
a definition of struct elf_prstatus.

IOW, #include <linux/elfcore.h> in any userland program is
going to blow - either due to redefinition of struct elf_prstatus
or due to incomplete type of member in that definition, depending
upon the headers we'd pulled in earlier.

Seeing that there's no userland code that would manage to pull that
file, is there any point exporting it at all?
