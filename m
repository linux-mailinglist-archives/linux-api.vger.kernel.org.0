Return-Path: <linux-api+bounces-145-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43C7F63FC
	for <lists+linux-api@lfdr.de>; Thu, 23 Nov 2023 17:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0132818ED
	for <lists+linux-api@lfdr.de>; Thu, 23 Nov 2023 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39D3C6B4;
	Thu, 23 Nov 2023 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRHhRKo6"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53113FB25;
	Thu, 23 Nov 2023 16:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60A2C433CA;
	Thu, 23 Nov 2023 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700757195;
	bh=SG11iwaP+p3koKgEoIVWXgRVVhH7qW0Y0/2cmw+cMpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRHhRKo69OXirFp+Rt89lJzssRTbqTsohTNQcXFTUxdRnQHui3q8TSYSPO8SKrQC/
	 apsxzb02JH6F8E2/A8Y+mQWA9CSforGzyx14GmG7KtRdXJ7Fwo5ozuYo+xctTezX+6
	 e4Z/UJVWbDFeJ+rPhV9+qTdkb0dQIV4kJSt7WVlBa/pi5TVSzIOXE77wAvq/ekeZ7Y
	 fR0IriTFRegUMQnRs0pPjjJJoK6QZUFgQN2caRms+YlTkpkK8Xcqkvp6z5rxLi9DZg
	 yQ5mBweHcpFEcaw+ukuWs7hps2RwbRsdWJWFym5IL855bTKNlgyA7iJNkrhXvxnXMP
	 jiPPfmnIZs8Hw==
Date: Thu, 23 Nov 2023 17:33:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v3 2/5] fork: Add shadow stack support to clone3()
Message-ID: <20231123-ausziehen-harpune-d020d47f964c@brauner>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-2-a7b8ed3e2acc@kernel.org>
 <20231123-derivate-freikarte-6de8984caf85@brauner>
 <ZV9Cz00vAKd7EwKD@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV9Cz00vAKd7EwKD@finisterre.sirena.org.uk>

On Thu, Nov 23, 2023 at 12:17:19PM +0000, Mark Brown wrote:
> On Thu, Nov 23, 2023 at 11:28:47AM +0100, Christian Brauner wrote:
> > On Mon, Nov 20, 2023 at 11:54:30PM +0000, Mark Brown wrote:
> 
> > Any reasonably maximum that should be assumed here? IOW, what happens if
> > userspace starts specifying 4G shadow_stack_size with each clone3() call
> > for lolz?
> 
> I guess we could impose RLIMIT_STACK?

Yeah, that also seems to be what acct_stack_growth() is using.

> 
> > > +	} else {
> > > +		/*
> > > +		 * For CLONE_VFORK the child will share the parents
> > > +		 * shadow stack.  Make sure to clear the internal
> > > +		 * tracking of the thread shadow stack so the freeing
> > > +		 * logic run for child knows to leave it alone.
> > > +		 */
> > > +		if (clone_flags & CLONE_VFORK) {
> > > +			shstk->base = 0;
> > > +			shstk->size = 0;
> > > +			return 0;
> > > +		}
> 
> > Why is the CLONE_VFORK handling only necessary if shadow_stack_size is
> > unset? In general, a comment or explanation on the interaction between
> > CLONE_VFORK and shadow_stack_size would be helpful.
> 
> This is the existing implicit behaviour that clone() has, it's current
> ABI for x86.  The intent is that if the user has explicitly configured a
> shadow stack then we just do whatever they asked us to do, if they

So what I'm asking is: if the calling process is suspended until the
child exits or exec's does it make sense for the child to even get a
shadow stack? I don't know the answer which is why I'm asking.

