Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4472034A0BC
	for <lists+linux-api@lfdr.de>; Fri, 26 Mar 2021 06:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCZE7t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Mar 2021 00:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhCZE7S (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 26 Mar 2021 00:59:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D88B261A2D
        for <linux-api@vger.kernel.org>; Fri, 26 Mar 2021 04:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616734758;
        bh=dEk8ZXGgMpgPdB95Q+GWWYAMhYOliJnVarqq5EcDWEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZQeWguAlR+bYr20n5WpPU3pQNOamMrLc2dnV7B4ai1NtLQ8wfs5VCmnzJ9CZVw72d
         20Ng3IunT5xnNB5qrXp+V/pL/RXduKSLnEmIJAIbCWGmz5KWXWB4EvCeFOU35AH3VF
         YRxfWv2a7Me2xlAY1Fb0KUcXcj8jNrZB3Ei7/0S4s8bP434dFm2Kf+4IZiIRP6xBN0
         fHXzjrThMDu86//C6770IBNoSBT5Ote2QNlp98A8eUGUUin8GDp6GPe1tW9BuYg4RW
         6Kf/x+ed2dc0txNyJe7mnyMjUFXzdUhL4qKryJsh9YWSUrBquEZjAJzkkNYgb7IpmF
         McVHRrUdZ/Ydg==
Received: by mail-wr1-f44.google.com with SMTP id z2so4379477wrl.5
        for <linux-api@vger.kernel.org>; Thu, 25 Mar 2021 21:59:17 -0700 (PDT)
X-Gm-Message-State: AOAM530iZJHLAPxNkaDSx6W/sRIc6pLCdlr88CIOnkZp+OeJoPjQLF97
        X/HIDpwI2xjiJxDIoL2+5h4AZN3pSK7jp7nvhhRD0g==
X-Google-Smtp-Source: ABdhPJxCxNQfg/K4yaCHgGuHl7WepFi+j5GnPwB/0t0ZibWzhF4vOLkV71zCZw4RX4om+spYA/cLAkttnsbBPJK4pho=
X-Received: by 2002:a17:906:7e12:: with SMTP id e18mr13774986ejr.316.1616734745657;
 Thu, 25 Mar 2021 21:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com> <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
In-Reply-To: <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Mar 2021 21:58:54 -0700
X-Gmail-Original-Message-ID: <CALCETrVRz8kvqxk2Xg5=c_0YWcgofXnqPb3uZRcca9pphE0sHg@mail.gmail.com>
Message-ID: <CALCETrVRz8kvqxk2Xg5=c_0YWcgofXnqPb3uZRcca9pphE0sHg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I forgot to mention why I cc'd all you fine Xen folk:

On Thu, Mar 25, 2021 at 11:13 AM Andy Lutomirski <luto@kernel.org> wrote:

>
> >         } else if (IS_ENABLED(CONFIG_X86_32) &&
> >                    !onsigstack &&
> >                    regs->ss != __USER_DS &&

This bit here seems really dubious on Xen PV.  Honestly it seems
dubious everywhere, but especially on Xen PV.

--Andy
