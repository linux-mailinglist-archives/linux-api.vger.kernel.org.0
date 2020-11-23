Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E092C04E8
	for <lists+linux-api@lfdr.de>; Mon, 23 Nov 2020 12:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgKWLtm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Nov 2020 06:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbgKWLtl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Nov 2020 06:49:41 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D018D20756;
        Mon, 23 Nov 2020 11:49:38 +0000 (UTC)
Date:   Mon, 23 Nov 2020 11:49:36 +0000
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
Message-ID: <20201123114935.GD17833@gaia>
References: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
 <87h7pj1ulp.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7pj1ulp.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 20, 2020 at 05:22:58PM -0600, Eric W. Biederman wrote:
> Peter Collingbourne <pcc@google.com> writes:
> 
> > Architectures that support address tagging, such as arm64, may want to
> > expose fault address tag bits to the signal handler to help diagnose
> > memory errors. However, these bits have not been previously set,
> > and their presence may confuse unaware user applications. Therefore,
> > introduce a SA_EXPOSE_TAGBITS flag bit in sa_flags that a signal
> > handler may use to explicitly request that the bits are set.
> >
> > The generic signal handler APIs expect to receive tagged addresses.
> > Architectures may specify how to untag addresses in the case where
> > SA_EXPOSE_TAGBITS is clear by defining the arch_untagged_si_addr
> > function.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > Link: https://linux-review.googlesource.com/id/I16dd0ed2081f091fce97be0190cb8caa874c26cb
> > ---
> > To be applied on top of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11
> 
> I have merged this first patch into signal-for-v5.11 and pushed
> everything out to linux-next.

Thank you Eric. Assuming this branch won't be rebased, I'll apply the
arm64 changes on top (well, if you rebase it, just let me know so that
we don't end up with duplicate commits in mainline).

-- 
Catalin
