Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9432C0FB2
	for <lists+linux-api@lfdr.de>; Mon, 23 Nov 2020 17:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgKWP7y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Nov 2020 10:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389608AbgKWP7y (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Nov 2020 10:59:54 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAAF320719;
        Mon, 23 Nov 2020 15:59:49 +0000 (UTC)
Date:   Mon, 23 Nov 2020 15:59:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v21 1/2] signal: define the SA_EXPOSE_TAGBITS bit in
 sa_flags
Message-ID: <20201123155946.GA2438@gaia>
References: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
 <87h7pj1ulp.fsf@x220.int.ebiederm.org>
 <20201123114935.GD17833@gaia>
 <87y2isysra.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2isysra.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 23, 2020 at 09:53:13AM -0600, Eric W. Biederman wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Fri, Nov 20, 2020 at 05:22:58PM -0600, Eric W. Biederman wrote:
> >> Peter Collingbourne <pcc@google.com> writes:
> >> > Architectures that support address tagging, such as arm64, may want to
> >> > expose fault address tag bits to the signal handler to help diagnose
> >> > memory errors. However, these bits have not been previously set,
> >> > and their presence may confuse unaware user applications. Therefore,
> >> > introduce a SA_EXPOSE_TAGBITS flag bit in sa_flags that a signal
> >> > handler may use to explicitly request that the bits are set.
> >> >
> >> > The generic signal handler APIs expect to receive tagged addresses.
> >> > Architectures may specify how to untag addresses in the case where
> >> > SA_EXPOSE_TAGBITS is clear by defining the arch_untagged_si_addr
> >> > function.
> >> >
> >> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> >> > Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> > Link: https://linux-review.googlesource.com/id/I16dd0ed2081f091fce97be0190cb8caa874c26cb
> >> > ---
> >> > To be applied on top of:
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11
> >> 
> >> I have merged this first patch into signal-for-v5.11 and pushed
> >> everything out to linux-next.
> >
> > Thank you Eric. Assuming this branch won't be rebased, I'll apply the
> > arm64 changes on top (well, if you rebase it, just let me know so that
> > we don't end up with duplicate commits in mainline).
> 
> No.  I won't be rebasing it.  Not unless something serious problem shows
> up, and at that point I will be more likely to apply a corrective change
> on top that you can also grab.

Thanks Eric. During the merging window, I'll probably wait for you to
send the pull request first just to keep the arm64 diffstat simpler.

BTW, did you mean to base them on v5.10-rc3-391-g9cfd9c45994b or just
v5.10-rc3? It doesn't matter much as I'll generate the diffstat manually
anyway in my pull request as I have different bases in other branches.

-- 
Catalin
