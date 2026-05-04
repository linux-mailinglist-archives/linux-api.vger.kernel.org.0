Return-Path: <linux-api+bounces-6261-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GxGDM/a+GnG2QIAu9opvQ
	(envelope-from <linux-api+bounces-6261-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 19:43:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A04C20D3
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8C7730485C7
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2026 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226D3E4C79;
	Mon,  4 May 2026 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="CB+mEt8T"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF23E51CF
	for <linux-api@vger.kernel.org>; Mon,  4 May 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916487; cv=none; b=ot23Zol/SWWnLldYEhY64kJioR/d/ykDFuXAZBUwvV76LyfSxWM/wiT+he3GwCbMvkxrOCcjbvdUmCWNXN9K2XjowqxefgNLTGGHYVhg4ACmOFmyidxvUbBLEObFZHJbEGD9hkfwTlFNrUaJLJQ1086Ius4ty8qhx17QzSnUf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916487; c=relaxed/simple;
	bh=T0R5oShVL9DF3ukvuDQvHdiJ/o761Zq2ZpTk4m6QFrk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Je7AzZKAfM572MgXhCHFKFUbFQskhStN0Ws66l2BKlBCUz79Hci2o/nkaR+kExOZTY58caq+bx+bYH5BPnqcF2MN79gPT7ZSARGxzOw34qfCHuCno/wyejgESy2U54D6VQzvXZ+xLEuUL143OJammCzfa99kG+wbLM1ieJfR2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=CB+mEt8T; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 73717a2e-47e0-11f1-afe2-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 73717a2e-47e0-11f1-afe2-005056994fde;
	Mon, 04 May 2026 19:41:16 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 737004dc-47e0-11f1-b5d2-0050569981f5;
	Mon, 04 May 2026 19:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=/ynlSJMPqfbLbvNL5NiC19w0yuRUPJanIcitny5Df/k=;
	b=CB+mEt8TzQPKGnImhTF/Z45zxKFff35iw/zJIb3j/KcCWlLFR98nriDkqkfTa6jXE5NJhnvhewuAb
	 svtZWQ1xTZxJYSOQ2AyWCFwIW6oWL+OSu/Z8QLdFzqBjbT/lQO03nP1mdcUeAErJZwh6qZHc5iLgGr
	 vxFYxewIt44MFyKFPn39aq9Fq2Xu6p7EYbK9eKt7q7ZONpTH41quoEvtle+jsY57MhD3G1HKR9JBNH
	 sQMcE6DgpPVEjqUichoBVh/lVzlpWt2CiVSVO26cXFfme84PRDUJcvs/udsSTEwOxF5Hw2TON+6plC
	 RJ6RryiyRFe39IWv+5HGq7FKVnLS8kA==
X-KPN-MID: 33|e8+pJRKQ8FkoXtJ35182rskBIUFWw22eXeogVVaBP4Y05ToouxOgAdQ5OKftghR
 jJ2S1gl2g6z9te9fOQDNDTPA3Tpe2Q0A4b4r2g/zZXrU=
X-CMASSUN: 33|y/an9B+ieBBE4jHK2/83KwCXvNNIRvQvpy2tOTvDShVYrIUK/U3DNJVYp9s4+Hv
 U93T5IKjerCciXNHV3gyQPw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 73638eac-47e0-11f1-b8d7-005056995d6c;
	Mon, 04 May 2026 19:41:15 +0200 (CEST)
Date: Mon, 4 May 2026 19:41:15 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Weißschuh <thomas.weissschuh@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	cmirabil@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org
Message-ID: <1600596489.77018.1777916475931@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns
 an O_DIRECTORY fd
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: A23A04C20D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6261-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:dkim]


> Op 27-04-2026 17:48 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> So definitely a patchset worthing doing but this will be hairy. And
> Mateusz is right. As written this doesn't work. The canonical pattern
> how e.g., dentry_open() does it is to preallocate the file.
> 

Is this because of Mateusz point that we should fail as soon as possible
to prevent any fs changes from taking effect?

But like Mateusz points out, this is not really happening for open() with
O_CREAT either. So is there any policy for what we do and do not tolerate?
(although I agree we should definitely preallocate the file; thanks for
pointing that pattern out).

> I do wonder though whether we shouldn't just make O_CREAT | O_DIRECTORY
> work. I remember that I had a vague comment about this in [1] a few
> years ago (cf. [1]). It might even be less hairy to get that one right
> as all the thinking for O_CREAT is already there.
> 
> What was the rationale for mkdirat2() instead of threading this through
> openat()/openat2() with O_CREAT?
> 

Because of Mateusz' objection, but I agree with Aleksa (and you in 2023)
that this is intuitive and you mentioned POSIX allows for it.

But a more general issue, that also applies to this mkdirat2 patch,
is Linus' objection in that same thread.[1] However, the use-case of
the UAPI request is different. Still, do we have any concrete examples
of programs that need to do such permissions/ownership/labels
/timestamps/acls/xattrs changes concurrently with another process
that has delete and create permissions in the same folder, and that
currently relies on the fstat() workaround?

> And side-question: @Jeff, can nfs atomic open deal with O_CREAT |
> O_DIRECTORY?
> 
> [1]: 43b450632676 ("open: return EINVAL for O_DIRECTORY | O_CREAT")


[1]: https://lore.kernel.org/lkml/CAHk-=wgLimhZ8px+BxTvkonBGHr9oFcjrk4tmE2-_mmd3vBGdg@mail.gmail.com/

