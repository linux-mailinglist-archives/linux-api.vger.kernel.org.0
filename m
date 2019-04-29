Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00E3E6A3
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfD2PgB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 11:36:01 -0400
Received: from monster.unsafe.ru ([5.9.28.80]:44264 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfD2PgB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 29 Apr 2019 11:36:01 -0400
Received: from dhcp129-178.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id CDA5EC61824;
        Mon, 29 Apr 2019 15:35:57 +0000 (UTC)
Date:   Mon, 29 Apr 2019 17:35:55 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jessica Yu <jeyu@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH v3] moduleparam: Save information about built-in modules
 in separate file
Message-ID: <20190429153555.GX9023@dhcp129-178.brq.redhat.com>
References: <20190429090854.GU9023@dhcp129-178.brq.redhat.com>
 <CAK7LNARpeSTr=VWudDRQ8sobcPQqtqzcLm7EqyvoKFYT84Hk6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARpeSTr=VWudDRQ8sobcPQqtqzcLm7EqyvoKFYT84Hk6Q@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 30, 2019 at 12:08:44AM +0900, Masahiro Yamada wrote:
> >  modules.builtin
> > +modules.builtin.modinfo
> >
> >  #
> >  # Top-level generic files
> 
> 
> Let me repeat the same comments as in v2
> (https://patchwork.kernel.org/patch/10888207/#22595563)
> as you ignored them.

I miss it. Sorry about that.

> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index c8cf45362bd6..41ef7cb043c1 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -226,6 +226,10 @@ modpost_link vmlinux.o
> >  # modpost vmlinux.o to check for section mismatches
> >  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
> >
> > +info MODINFO modules.builtin.modinfo
> > +"${OBJCOPY}" -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
> > +chmod 444 modules.builtin.modinfo
> 
> 
> Why is this 'chmod 444' necessary?

I just wanted to show that this file will never change.
I will remove this line.

-- 
Rgrds, legion

