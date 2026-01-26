Return-Path: <linux-api+bounces-5751-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOPFNK3LdmltWgEAu9opvQ
	(envelope-from <linux-api+bounces-5751-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 26 Jan 2026 03:04:29 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 753048364D
	for <lists+linux-api@lfdr.de>; Mon, 26 Jan 2026 03:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3305630038FA
	for <lists+linux-api@lfdr.de>; Mon, 26 Jan 2026 02:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43015CD7E;
	Mon, 26 Jan 2026 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aG+yVF1i"
X-Original-To: linux-api@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF31AC44D
	for <linux-api@vger.kernel.org>; Mon, 26 Jan 2026 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393067; cv=none; b=Hs8LRdSRDusUHMR/nYa/raXLizGX38TJsSHHMfSS/ECbYymalT1W0WFrzGJOMAX8oRbMK2VnpMlP3z7HMHU3inBVy9x4/b2JnE8jVuI+L+fUZ5wsI2/VX/OxEEbxJgQiTsFT1DpgDnQhs7hHsU6j+BF+X2/LzF/SHY5dAf37I4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393067; c=relaxed/simple;
	bh=Qho4rFAhh+NNqe9GgWpu1b9P3YLzTlEjhXB2mMkvjIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB/zcB8jZlpI5TEXO7S3SRu3hPFQpzJjBK18uC3+6w/tXWCbkvKuNf8JHh63pv6rFyRYpQoLPPGRhoAPdlgiDe2PNQ8gj3nqfvPi+GXRJH9Cu7acZyvY98dArVq5C1Zn8Zm6GOhbVWT04au6ynSKhhUTgUrx3vuQ+LqUChonKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aG+yVF1i; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <541db2c8-7a96-4cc3-835e-b0eac64d4e3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769393053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YU2NlokWChX+w+wYFtB0VNNjx1y0MJTSqOSPtiMrZJc=;
	b=aG+yVF1iuAkfFXb5QrSJdMFLtW8l+pRkmAMZl5JX5LKO+N9E3qDxLqUg7xTYdEwZZ7B8yc
	gEJ3tsqciT1taB9oDsHk5PJvxedvZVnF9PwLtRRepoc5ThIVM8DBuXXjN3lH3MOc8D78uS
	JTWZky/knscIsOLdIbMRc4I6UyfcA/g=
Date: Mon, 26 Jan 2026 10:03:54 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 2/9] libbpf: Add support for extended bpf
 syscall
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>,
 Andrey Albershteyn <aalbersh@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260123032445.125259-1-leon.hwang@linux.dev>
 <20260123032445.125259-3-leon.hwang@linux.dev>
 <CAADnVQJLz+nMHCZXUgy2MOxwFczEHNbG8ZUgfZeUY4yXFUKcNw@mail.gmail.com>
 <a0ce1dab-7d7e-4b04-a033-4f0611090d34@linux.dev>
 <CAADnVQ+HJkOikzE3KPhOkd1KNugs7=1dZKY1mfog-ez8noyrDA@mail.gmail.com>
 <419976da-f296-4418-8dfe-8ad50a9f8cb5@linux.dev>
 <CAEf4BzYhhf7Jd6DDr2XVf=3gKeMMmrkWW9Sr49QxuW6QudSKig@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYhhf7Jd6DDr2XVf=3gKeMMmrkWW9Sr49QxuW6QudSKig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5751-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 753048364D
X-Rspamd-Action: no action



On 24/1/26 02:52, Andrii Nakryiko wrote:
> On Thu, Jan 22, 2026 at 8:19 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 23/1/26 12:12, Alexei Starovoitov wrote:
>>> On Thu, Jan 22, 2026 at 8:07 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>> On 23/1/26 11:55, Alexei Starovoitov wrote:
>>>>> On Thu, Jan 22, 2026 at 7:25 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>>>
>>>>>>
>>>>>> +static int probe_bpf_syscall_common_attrs(int token_fd)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       ret = probe_sys_bpf_ext();
>>>>>> +       return ret > 0;
>>>>>> +}
>>>>>
>>>>> When you look at the above, what thoughts come to mind?
>>>>>
>>>>> ... and please don't use ai for answers.
>>>>
>>>> My initial thought was whether probe_fd() is needed here to handle and
>>>> close a returned fd, since the return value of probe_sys_bpf_ext() isn’t
>>>> obvious from the call site.
> 
> Have you looked at how probes are called (in feat_supported()?) They
> all follow the same contract: > 0 (normally just 1) means feature is
> supported, 0 means feature is not supported, and <0 means something
> went wrong. Libbpf will log an error and will assume feature is not
> supported.
> 

I’ve looked at feat_supported().

Even though I was aware of the probe contract, I should have thought it
through more carefully in the context of feat_supported() and
probe_sys_bpf_ext(). With that in mind, your suggestion makes sense now.

> probe_sys_bpf_ext() should either follow that convention or drop the
> probe_ prefix altogether to avoid confusion. And then
> probe_bpf_syscall_common_attrs() is necessary only as a wrapper around
> probe_sys_bpf_ext() to ignore mandatory (but unused) token_fd argument
> (so to make it "pluggable" into feat_supported() framework).
> 
> So, just make probe_sys_bpf_ext() follow probe contract as described,
> and then just:
> 
> static int probe_bpf_syscall_common_attr(int token_fd)
> {
>     return probe_sys_bpf_ext();
> }
> 

I’ll make probe_sys_bpf_ext() follow the standard probe convention, and
keep probe_bpf_syscall_common_attrs() as a thin wrapper to ignore the
mandatory (but unused) token_fd argument, so it plugs cleanly into
feat_supported() framework.

> Alternatively, just make probe_sys_bpf_ext() take token_fd (but ignore
> it), and just use probe_sys_bpf_ext() directly for feat_supported().
> 
> 
> probe_fd() is not suitable here because it's for a common case when we
> expect syscall to succeed and create fd, in which case that successful
> fd represents successful feature detection. This is not the case here,
> so probe_fd() is not what you should use.
> 

Agreed as well that probe_fd() is not suitable here, since this probe is
not expected to return a successful FD.

Thanks for the detailed explanation.

Thanks,
Leon

>>>
>>> Fair enough, but then collapse it into one helper if FD is a concern.
>>> My question was about stylistic/taste preferences.
>>
>> Understood, thanks for the clarification.
>>
>> I’ll rework it with the stylistic preference in mind.
>>
>> Thanks,
>> Leon
>>


