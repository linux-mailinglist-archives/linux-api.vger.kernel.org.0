Return-Path: <linux-api+bounces-5811-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CFVJN5VhWmnAAQAu9opvQ
	(envelope-from <linux-api+bounces-5811-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 06 Feb 2026 03:45:50 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E4F96B2
	for <lists+linux-api@lfdr.de>; Fri, 06 Feb 2026 03:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 587BF300698C
	for <lists+linux-api@lfdr.de>; Fri,  6 Feb 2026 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A61528B4FA;
	Fri,  6 Feb 2026 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oPwCIleO"
X-Original-To: linux-api@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98352580EE;
	Fri,  6 Feb 2026 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345943; cv=none; b=I7lrjApB71Ouao8JCoKLMyIvYMYHx/gbONtBhmCOqY47TCyUsziW6Kr8RL3naw+b+329ctDArq+G+lJSTAoSIoyPnyU23ca7BOYgsQxGaj+MviaxfvywSrZLlLzyi+YF1Em69y5R8dU8uEEmBFb4lIyuTTTvZJzOWUxKO8vBS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345943; c=relaxed/simple;
	bh=Z+JWro3E8aRvfngoe/6LubDVzHtuFX4mcalY38TDisw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3s9RO9R3323xeN1rKjBI4tGrFM9Gl6picPf6DCJDPrKCZKOsfv4W6bWYdDQv9qJLcZ64MMwmfqLe20hsHWi3zCmnYZPOlccMeNi6lreGY9zuRXhzESCHODLEnTtyFVM8gghK/TqNcAi8nq2zNJ1w+LUSprnQjb62qpCfV0noqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oPwCIleO; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <097f4aa3-dfa6-4847-8395-8108323b020f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770345930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFSlinCyA0+SI/xvgDMbNOQR7AvWVKP4QIPnbgTtWvc=;
	b=oPwCIleO+x6qGEM2MPOk1oahBLC874RmsIV3FYPsjS+ThIOuUSrGtg98iITL0/cFrXRZKv
	FmzYyBU1skxQCEk+86jQvm43siMpAk1ABkej8TKgy1HwY46NqkWGCv5Qb7dhAJ63JJSaiI
	QNGZyT7v88Mc/Wk19Mj48rwvkeUtU5c=
Date: Fri, 6 Feb 2026 10:45:17 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 4/9] bpf: Add syscall common attributes
 support for prog_load
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260202144046.30651-1-leon.hwang@linux.dev>
 <20260202144046.30651-5-leon.hwang@linux.dev>
 <CAEf4Bza-PM9ExqJS=Q_oj7Cqc5dvmbN_Zv9-4UnJNtsZU28FoQ@mail.gmail.com>
 <a31b7f19-a22a-44ab-8ecd-9df9dead9c3d@linux.dev>
 <CAEf4BzZWawrE+mXaPNPAT8zcz0Qy+5QYA6r4JzEVw7UAcUH-uA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZWawrE+mXaPNPAT8zcz0Qy+5QYA6r4JzEVw7UAcUH-uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5811-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B86E4F96B2
X-Rspamd-Action: no action



On 6/2/26 06:18, Andrii Nakryiko wrote:
> On Wed, Feb 4, 2026 at 7:42 PM Leon Hwang <leon.hwang@linux.dev> wrote:

[...]

>>>> +
>>>> +       if (!attr->log_buf && attr_common->log_buf) {
>>>> +               attr->log_buf = attr_common->log_buf;
>>>> +               attr->log_size = attr_common->log_size;
>>>> +               attr->log_level = attr_common->log_level;
>>>
>>> why are we setting this? Do we still have code that can access
>>> attr->log_buf even though we pass attr_log everywhere? If yes, should
>>> we still have that "split brain" code?
>>>
>>
>> 'attr->log_buf' is accessed only in bpf_check().
> 
> bpf_check should be changed then, see below
> 
>>
>>> If we don't have this assignment, then I think we don't need to have
>>> bpf_prog_load-specific and btf_load-specific log_attr_init() helpers.
>>> They can be unified into generic log_attr_init, where for
>>> bpf_prog_load you'll pass offsetof(log_true_size) +
>>> attr->log_{buf,size,level}, and for btf_load you'll pass different
>>> offset of and btf-specific attr->btf_log*
>>>
>>> This helper will just be making decision whether to use common_attr's
>>> log fields or passed directly command-specific ones.
>>>
>>> Or what am I missing?
>>>
>>
>> If the log attributes differ, where should the effective
>> log_* values be stored?
>>
>> Should they live in struct bpf_common_attr, or should we extend
>> struct bpf_log_attr to carry them?
>>
>> Note that in v8, Alexei suggested struct bpf_log_attr only needs
>>   u32 offsetof_true_size;
>>   bpfptr_t uattr;
>>
>> so I’d like to clarify the intended direction here. Once that’s clear, a
>> single generic log_attr_init() should be sufficient to handle this.
>>
> 
> The intended direction is to have log buf/size/level in one place
> (after attr and common_attr validations), so we keep internal logic
> simple. Let's put all of that and log_true_size **pointer** (we don't
> have to much with offsetof, just calculate user addr for
> log_true_size, which just might be NULL) into bpf_log_attrs and teach
> all code to look and work *only* with that struct, ignoring anything
> log related from attr.
> 
It’s clear now.

I’ll follow this direction in the next revision and consolidate all
log-related fields (including the log_true_size pointer) into
bpf_log_attr, so that internal code relies solely on that struct.

Thanks,
Leon


