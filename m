Return-Path: <linux-api+bounces-5736-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGGVGAf0cmmhrQAAu9opvQ
	(envelope-from <linux-api+bounces-5736-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 05:07:35 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19E703DF
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 05:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 416963007297
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267E37F8B2;
	Fri, 23 Jan 2026 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cPxbhWJP"
X-Original-To: linux-api@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FC36D508;
	Fri, 23 Jan 2026 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769141236; cv=none; b=P/hBQSJ8Rb6iFEI7V7Z4x7LQoYv1FbVfLM1oEZviXbWDL4Agg19V33OA1zYJ2qDk7v1T91eK2eNnj91VipoYBsuJw5SRwQ2HMJCm0hbiSCOchXC2jfC/cSRa67+rTnmNhmGoXA0bu6HDIqg3guT4t4o2dHRfIdUaBxX7Abc05Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769141236; c=relaxed/simple;
	bh=v6kZZe7ybcJOjR9F1ZeiyHnchWeMvm5tLOBTEA5FXpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4k+KR9d4Q4EJKQmrnpUQJQ+jTdPozA9laHdEvL7/q1KRZUiwH6XDqU7bher49uyLYiz4MBO92mhE8p4OFLzulI4R6xTTPetl2FS2IRlOwDvvl8QtYw8Qd/X8ij25vMMFbH+2zZCsczigWU8NWjukNLkjZWEsYhnO6qO4JJ3TpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cPxbhWJP; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0ce1dab-7d7e-4b04-a033-4f0611090d34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769141227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UdGSl1zFpyYo7ZLism+9vO/YeG3Eo+vsrATosec5nQ=;
	b=cPxbhWJPP5B2CyugGIqAuhz8oDEcxXLVkBcTMAYNhDWaNyc4IBpuNcwyu9xHAR5/66xOAn
	VnIPu6PvOBzokmE1gkoZCHpSmqOR6xzbaosA4w5U46YP19U45z8FyVR/AW0Qed6XS5F6GJ
	0qh+UnZQImb4WBhZ6DzaJeky9Ws4sio=
Date: Fri, 23 Jan 2026 12:06:45 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJLz+nMHCZXUgy2MOxwFczEHNbG8ZUgfZeUY4yXFUKcNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5736-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[linux.dev:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE19E703DF
X-Rspamd-Action: no action



On 23/1/26 11:55, Alexei Starovoitov wrote:
> On Thu, Jan 22, 2026 at 7:25 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>> +static int probe_bpf_syscall_common_attrs(int token_fd)
>> +{
>> +       int ret;
>> +
>> +       ret = probe_sys_bpf_ext();
>> +       return ret > 0;
>> +}
> 
> When you look at the above, what thoughts come to mind?
> 
> ... and please don't use ai for answers.

My initial thought was whether probe_fd() is needed here to handle and
close a returned fd, since the return value of probe_sys_bpf_ext() isn’t
obvious from the call site.

Thanks,
Leon


