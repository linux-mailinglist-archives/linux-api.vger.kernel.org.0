Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5D1F6F80
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2020 23:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFKVff (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jun 2020 17:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgFKVff (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jun 2020 17:35:35 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2028C08C5C1
        for <linux-api@vger.kernel.org>; Thu, 11 Jun 2020 14:35:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jjUrC-007GHL-Ke; Thu, 11 Jun 2020 21:35:30 +0000
Date:   Thu, 11 Jun 2020 22:35:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC] unexport linux/elfcore.h
Message-ID: <20200611213530.GB23230@ZenIV.linux.org.uk>
References: <20200611010115.GZ23230@ZenIV.linux.org.uk>
 <20200611152344.GA1693733@ZenIV.linux.org.uk>
 <CAHk-=wijbWCfZaiYO68MSfxz-UMuJCuO1Sr9O1x4BTPpMjm4gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijbWCfZaiYO68MSfxz-UMuJCuO1Sr9O1x4BTPpMjm4gw@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 11, 2020 at 01:01:40PM -0700, Linus Torvalds wrote:
> On Thu, Jun 11, 2020 at 8:23 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I mean something like this.  Objections?
> 
> I'm not seeing that alot of people would care.
> 
> That said, is there any reason not to try to fix it instead and expose
> elf_gregset_t some way?
> 
> But I do suspect it all really boils down to "nobody cares". If you
> can't find somebody to speak up for it, might as well remove it.

Anyone who wants to use that stuff includes sys/procfs.h anyway (since
1996).  As for the reasons...  I would love to kill off these gems, for
example:
#define PRSTATUS_SIZE(S, R) (R != sizeof(S.pr_reg) ? 144 : 296)
#define SET_PR_FPVALID(S, V, R) \
  do { *(int *) (((void *) &((S)->pr_reg)) + R) = (V); } \
  while (0)
(x86 asm/compat.h)  And being able to massage the definition of
elf_prstatus (while keeping the size and layout - it describes
a part of file format, after all) would simplify the life alot.

struct __kernel_elf_prstatus would be an obvious solution, but...
nobody in userland pulls the definition in linux/elfcore.h and
hadn't been able to do that for at least a decade (if not more than
that).  So I'd rather get rid of exporting it.
