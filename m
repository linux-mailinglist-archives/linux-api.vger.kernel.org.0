Return-Path: <linux-api+bounces-6508-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +IX8FZcxIGqqyQAAu9opvQ
	(envelope-from <linux-api+bounces-6508-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 15:52:23 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A674638428
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 15:52:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c1ouCCeO;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6508-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6508-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C713308B132
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75515315785;
	Wed,  3 Jun 2026 13:40:44 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9492F7EEF;
	Wed,  3 Jun 2026 13:40:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494044; cv=none; b=IqZTnqw9grflu5GXNQKEtBvrWPB2qpfabK8IhvC6dur6NhQxGY5ZyrJimK7a58qoN/RcJudKVQ/C9f4LUvZT8BJG+wwcqmX6WGpea+NzPAp+Qu2sJ1D6qkdCYxsfB2WE9khvlUhwW3tEDpYw6PUAKML5Iq+RvdPnL1QK0HFK9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494044; c=relaxed/simple;
	bh=b6vBOlamIALY9QchbQL4bGF2Nouw+mjRGEs7YrsXTNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM6AXP31Z8B/Z0cT9ykvrYuUjg5NKHCqoP8EZSOAxGRSC9NeLE943CM0b3oQqo1D90H887Tjw16Fyp/TJ1G0y4gDlIRpQyOhXXyxrMzjbWbXoOwdh6BW/fkg7vODBz8U7wOQNrikCRZLJl/4FIgG4/tcex7cnp9JFUDlUqA+jBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1ouCCeO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4C61F00898;
	Wed,  3 Jun 2026 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494043;
	bh=KGsTHKQ9mld7YxQe3rajH7wvD+M6DWrkXFM9QhfOh6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c1ouCCeOfGsSWLGNkvvoOa5gTYM0YWhQ2YWKcMokI4OUSVIQBt0LDWDEXGXgdOBhk
	 RcRyl93QyEJ9JLW5AoFWnCmqBcXY4cK06cakG8SwHN1xGxeQjB9bXeW0akqq75vk2P
	 s1CIE2PyGQkPbaRlS08LsLJsqwRjPSYYv9Co1tKaf2nz1vK6+dOTW+wW6ZJys66m7i
	 l/CfFgBOqWkhIpv51rSLKkHcHCfO99JTOGnqyq9fBQ5yu+2Nk4F/mwwgwhNKVUGHUE
	 NbEKOEm1HAbHTIt1WY4dqDDq5U04q5ORt1Vz6IqwcdFYPqakOw4Ejt1EIbx3TDx8mS
	 7EOkXsCAM9FvQ==
Date: Wed, 3 Jun 2026 15:40:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, david@kernel.org, 
	dhowells@redhat.com, hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	miklos@szeredi.hu, netdev@vger.kernel.org, patches@lists.linux.dev, 
	pfalcato@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com>
 <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <20260603-navigieren-pleite-stilvoll-60e6da66b1d4@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603-navigieren-pleite-stilvoll-60e6da66b1d4@brauner>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6508-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amacapital.net,gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amacapital.net:email,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A674638428

On Wed, Jun 03, 2026 at 08:45:18AM +0200, Christian Brauner wrote:
> On Tue, Jun 02, 2026 at 09:20:13PM -0700, Linus Torvalds wrote:
> > On Tue, 2 Jun 2026 at 20:51, Andy Lutomirski <luto@amacapital.net> wrote:
> > >
> > > Am I understanding correctly that this will completely break zerocopy
> > > sendfile?
> > 
> > Very much, yes.
> > 
> > And it's worth making it very very clear that ABSOLUTELY NONE of the
> > recent big security bugs were in splice.
> > 
> > They were all in the networking and crypto code that just didn't deal
> > with shared data correctly.
> > 
> > So in that sense, it's a bit sad to discuss castrating splice.
> 
> Well, we're completely ignoring the fact that splice()'s locking and
> interactions with pipe_lock() are complete insanity. So unless someone
> sits down and really thinks about how to rework the locking I think
> degrading splice() is just fine.
> 
> > But it's probably still the right thing to at least try.
> 
> Yes.
> 
> > I just suspect we'll never get real answers without going the "let's
> > just see what happens" route...
> 
> Yes.

Reading this thread again I'm really amazed how willingly people argue
to remain locked into a really broken API even if they're giving a risk
but worthwhile chance to kill it for good. Anway, odd-userspace behavior
time:

David reported vmsplice01 failing in the LTP testsuite after the change:

11297 20:41:02.548383  <LAVA_SIGNAL_STARTTC vmsplice01>
11298 20:41:02.548518  tst_tmpdir.c:316: TINFO: Using /tmp/LTP_vmsZ13ZQj as tmpdir (tmpfs filesystem)
11299 20:41:02.548656  tst_test.c:2047: TINFO: LTP version: 20260130
11300 20:41:02.548793  tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc6-next-20260602 #1 SMP PREEMPT Tue Jun  2 18:13:29 UTC 2026 aarch64
11301 20:41:02.548932  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
11302 20:41:02.549069  tst_test.c:1875: TINFO: Overall timeout per run is 0h 01m 30s
11303 20:41:02.549205  tst_test.c:1632: TINFO: tmpfs is supported by the test
11304 20:41:02.549340  Test timeouted, sending SIGKILL!
11305 20:41:02.549477  tst_test.c:1947: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
11306 20:41:02.549614  tst_test.c:1949: TBROK: Test killed! (timeout?)
11307 20:41:02.549751  
11308 20:41:02.549887  Summary:
11309 20:41:02.550021  passed   0
11310 20:41:02.550155  failed   0
11311 20:41:02.550290  broken   1
11312 20:41:02.550450  skipped  0
11313 20:41:02.550582  warnings 0
11314 20:41:02.550710  
11315 20:41:02.550838  <LAVA_SIGNAL_ENDTC vmsplice01>

So I looked at the test:

	while (v.iov_len) {
		/*
		 * in a real app you'd be more clever with poll of course,
		 * here we are basically just blocking on output room and
		 * not using the free time for anything interesting.
		 */
		if (poll(&pfd, 1, -1) < 0)
			tst_brk(TBROK | TERRNO, "poll() failed");

		written = vmsplice(pipes[1], &v, 1, 0);
		if (written < 0) {
			tst_brk(TBROK | TERRNO, "vmsplice() failed");
		} else {
			if (written == 0) {
				break;
			} else {
				v.iov_base += written;
				v.iov_len -= written;
			}
		}

		SAFE_SPLICE(pipes[0], NULL, fd_out, &offset, written, 0);
		//printf("offset = %lld\n", (long long)offset);
	}

Prior to the change add_to_pipe() returns -EAGAIN the moment the pipe is
full. So iter_to_pipe stops and returns a partial count capped at pipe
capacity. For a 128K buffer over a 64K pipe the first call returns 64K,
the test drains it, call 2 returns the remaining 64K. Done.

After this change do_writev(... flags & SPLICE_F_NONBLOCK ? RWF_NOWAIT :
0) then calls pipe_write which does not stop when the pipe fills. It
blocks until the entire iovec is consumed.

I kinda think we need to preserve similar semantics.

