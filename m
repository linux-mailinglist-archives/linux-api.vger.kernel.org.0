Return-Path: <linux-api+bounces-5738-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ83JPH2cmnfrQAAu9opvQ
	(envelope-from <linux-api+bounces-5738-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 05:20:01 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 899B47046A
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 05:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6C0A300832D
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5F3816E0;
	Fri, 23 Jan 2026 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FSrZ/AcD"
X-Original-To: linux-api@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2B3542CC
	for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769141995; cv=none; b=MCNTYISaywEqbQJBvHrTZuiCL6WRfzo54HusrwFrzEcRiVsOOmE/0p7aLZFEVYej6XlqWeT2JR+wJBy5rspxDHb5anr2bSzSy94vtr5f8UQsIehd7+v8sag02E7wSnn5W40hDPJ+MX+PxmB6GrGMWK1JVZzchSlPnPSl+8wmzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769141995; c=relaxed/simple;
	bh=RuDKmPzam/EuDUoYAC2/gqr1k9Fh+lbHsbqj/Nvj084=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6OTLhvPAkAccVjVAo5TdtFBSlM0pEN+0YucYeNlR/0taKzjTQzWuw+hjUlmJncLwE4INp7jkd3jPwM3IqM6r/nn6i9wxsOhNhPptUtTgu3lc7FGhHuboc0ZZyR4wH3cE5DP3lu/nJ1YEyC2XHCzpXVW09XjiTyr4GvnWRC/7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FSrZ/AcD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <419976da-f296-4418-8dfe-8ad50a9f8cb5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769141964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9dCsAasU81DgQOPWYby6CnKTpdlUxy0vuA+UQwIUG4=;
	b=FSrZ/AcDPpY9IkgQtC/Tv0e7keIPTjH1XBfImUjNZRIT9mLlA7PUKgaMD3Idj83WJkGxHh
	dsdcUY59+YBg4vjgRFrhM6mObWSwHBKjoaMBoa4RR3E133M2vx2xXQ5tCnwrZbpEY/DQhl
	AqWNhE7jV8xVWhh8EgpEFmuyDVOuYmo=
Date: Fri, 23 Jan 2026 12:19:11 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 2/9] libbpf: Add support for extended bpf
 syscall
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+HJkOikzE3KPhOkd1KNugs7=1dZKY1mfog-ez8noyrDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5738-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 899B47046A
X-Rspamd-Action: no action



On 23/1/26 12:12, Alexei Starovoitov wrote:
> On Thu, Jan 22, 2026 at 8:07 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 23/1/26 11:55, Alexei Starovoitov wrote:
>>> On Thu, Jan 22, 2026 at 7:25 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>>
>>>> +static int probe_bpf_syscall_common_attrs(int token_fd)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       ret = probe_sys_bpf_ext();
>>>> +       return ret > 0;
>>>> +}
>>>
>>> When you look at the above, what thoughts come to mind?
>>>
>>> ... and please don't use ai for answers.
>>
>> My initial thought was whether probe_fd() is needed here to handle and
>> close a returned fd, since the return value of probe_sys_bpf_ext() isn’t
>> obvious from the call site.
> 
> Fair enough, but then collapse it into one helper if FD is a concern.
> My question was about stylistic/taste preferences.

Understood, thanks for the clarification.

I’ll rework it with the stylistic preference in mind.

Thanks,
Leon


