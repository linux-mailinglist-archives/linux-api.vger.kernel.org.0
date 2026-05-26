Return-Path: <linux-api+bounces-6414-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHt7EuDQFWrwcQcAu9opvQ
	(envelope-from <linux-api+bounces-6414-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 18:57:04 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22FE5DA331
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0ED531046B8
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E63BD62C;
	Tue, 26 May 2026 16:30:41 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41203B38AB;
	Tue, 26 May 2026 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813041; cv=none; b=iKuvNV+jFF4tPXfYqOnpMGDpTJ3Fd/A/tJm+Yg//JWT2Ba5BJ99fr58cS6L6Z5s3/12YO03NKSYrvJNx9ovLSqr4BpcnWjRyyR0skeRqc/n1T4Q/rb522G7ucBJ7VZMPDgg3kFcoAOThQgu0ocRx1hyvfLwo4l++NeM7DLoBLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813041; c=relaxed/simple;
	bh=4RHUPrOhy8Rckt9kmEsawMj3CTJh4VdgYBT2gsMHQC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aq1Lofxsn9KD65nuWXSShGIYxZH5Xrk2kbVpmE3KlzXMVu/FFTRzo/05qRdDHfMvgzEjwnT9tE4BIr0bAo68HeVn6FPo914OXR2nBiCZ7SlUUI77yuGlX9bam5nBpCu8fen4U4Ovtnztm182xiPTlzpsMyaZhU9RVCjU/nfzkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C20E31C033A;
	Tue, 26 May 2026 16:30:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 5CC3320010;
	Tue, 26 May 2026 16:30:31 +0000 (UTC)
Date: Tue, 26 May 2026 12:31:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Christian Brauner <brauner@kernel.org>, Kees
 Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, willy@infradead.org,
 mathieu.desnoyers@efficios.com, Linus Torvalds
 <torvalds@linux-foundation.org>, akpm@linux-foundation.org, Yafang Shao
 <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, arnaldo.melo@gmail.com,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, linux-mm@kvack.org, linux-api@vger.kernel.org,
 Bhupesh <bhupesh@igalia.com>
Subject: Re: [PATCH v2 4/6] sched: Extend task command name to 64 bytes
Message-ID: <20260526123103.4facbaed@gandalf.local.home>
In-Reply-To: <20260525114241.4b6f3050@pumpkin>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
	<20260524-tonyk-long_name-v2-4-332f6bd041c4@igalia.com>
	<20260525114107.7fa5b4c1@pumpkin>
	<20260525114241.4b6f3050@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4oyjjqmuesmiumwmpy1rnjhsc49eyn1n
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+SfqA0tIqUxOUmzDMPGsY2Bynwi9HM1FA=
X-HE-Tag: 1779813031-406674
X-HE-Meta: U2FsdGVkX19+DgaPTwc4z7iRVXUSZOqrVEfAtGYSvV7OnTDacZ1Hw/MUPKcmm575Hv6x6ldX6k779vnxNpGWZI83exoqPnaDvD3uiHdZGrm7O5Kn8tyfMud8UFNzBiy7OmfhPALhmcYjVcad5UeM/aK2bFkxfct7yhyONa0bUJwJQYnXpiEhTGrDK4+ottHoOwIGmxDD9djJ4vguO4i/d9n6iTmTLNIPSiyaJZcjqepQIJDHLt8k5S3jRqxtjKvWU+LHRBTYm/VmDYxSfyjZj3V/j8+bRbPwmMHzhEo8tM5IGa6nnWPigAFfptTCc/yad9e10ugVvl7w7SVjyWGNoeMVvvQ9cdK+
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6414-lists,linux-api=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[igalia.com,infradead.org,redhat.com,linaro.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.924];
	TAGGED_RCPT(0.00)[linux-api];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gandalf.local.home:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A22FE5DA331
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 11:42:41 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> > >  	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
> > > @@ -2601,16 +2601,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> > >  			error = -EINVAL;
> > >  		break;
> > >  	case PR_SET_NAME:
> > > -		comm[sizeof(me->comm) - 1] = 0;
> > > +		comm[TASK_COMM_LEN - 1] = 0;
> > >  		if (strncpy_from_user(comm, (char __user *)arg2,
> > > -				      sizeof(me->comm) - 1) < 0)
> > > +				      TASK_COMM_LEN - 1) < 0)    
> > 
> > Nak - you can't do that.
> > You are reading data that the application doesn't expect you to read.  
> 
> Or have I got confused over the names...

You may have gotten confused by names, as sizeof(me->comm) is the same as
TASK_COMM_LEN. Basically, the above doesn't change anything.

-- Steve

