Return-Path: <linux-api+bounces-6121-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J+hFvRa5mmtvAEAu9opvQ
	(envelope-from <linux-api+bounces-6121-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 18:57:24 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD8A43045C
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 18:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BACB3833BC5
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82733331A56;
	Mon, 20 Apr 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBmfdrTI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE62330D54;
	Mon, 20 Apr 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696992; cv=none; b=bt4MHjogMGqvbOfZvZhq5KIhumtgRGT6rROh1d2Iinu3o7k/cqgShUqfB3zHPByi+m+3Ar4i1LSywBo0Bun+4tTvi2t4eEn0Fg33IgNuf7p6UUWWrtEEtzfTpVZgS1LF7rapDdtBCNV1LV6P1VV93JmYTJglEVewF/oMbJZ7mO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696992; c=relaxed/simple;
	bh=dVGg36Jm3JOJj4RJsnXuw53h3TjAmab9ykPPMa0dbBo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s3mymZ9PHma+9vvP+qTOCZ9JmgktDFrvRRIr+0sEn1NJtCOk3wtx2KfLhIJdN4KJYX8v+4TbNkPQ+DCP3GOiwNuI9957P7IpboOz2H7b9Ga5/88dvFbgBATsvgLIPzIOzkj76CFzvx1FLG4MmZxufMGgsLMzHyiG4jMQWmLLp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBmfdrTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E67C19425;
	Mon, 20 Apr 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776696992;
	bh=dVGg36Jm3JOJj4RJsnXuw53h3TjAmab9ykPPMa0dbBo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TBmfdrTIcSZKH7RUNjd0zGVAFS0u38OHQkPW1dquVEj8IfYFDDCv35dojnhGW2Bic
	 mjvAGXhEomF4Dx0YPk3P9CbjlHWPe8hM0krwJNgcsrIPZC9dXwR7TP1eS1pWgswAol
	 lmdMd4QjsFMRVDTn9CoW5Pd0BJrVkur5ldFl4PO5QrdQmYYSrI1RHYTBqOEgJ5QTDY
	 SsTRZFQQhbzpVPM63QYdW2rJPpCpQ2M1iU3DAaqWmGZsNnc7T27UtsP3WU4uOgnZyz
	 gklPEaDlClWtw9q+0iL7LbDGXH/OqTxkZzA3K+CVnDlS10tQmTLR/2uBLoTf5ZJVbY
	 Ah4T0EFJCN+vQ==
Content-Type: multipart/mixed; boundary="===============1167874149647582553=="
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a007ad07d6c91fc692fe29e0a57f1f6059f27eb4d147cb987d01f955b76d3c36@mail.kernel.org>
In-Reply-To: <20260420141804.27179-6-leon.hwang@linux.dev>
References: <20260420141804.27179-6-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 5/8] bpf: Add syscall common attributes support for btf_load
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,brauner@kernel.org,sforshee@kernel.org,yuichtsu@amazon.com,aalbersh@redhat.com,leon.hwang@linux.dev,willemb@google.com,kerneljasonxing@gmail.com,chen.dylane@linux.dev,yatsenko@meta.com,memxor@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,linux-kernel@vger.kernel.org,linux-api@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 20 Apr 2026 14:56:31 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-api@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6121-lists,linux-api=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDD8A43045C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============1167874149647582553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1eb15a51c7dc..06aea4e499a1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -6317,7 +6317,12 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>  		err = bpf_raw_tracepoint_open(&attr);
>  		break;
>  	case BPF_BTF_LOAD:
> -		err = bpf_btf_load(&attr, uattr, size);
> +		if (size >= offsetofend(union bpf_attr, btf_log_true_size))
> +			offsetof_log_true_size = offsetof(union bpf_attr, btf_log_true_size);
> +		err = bpf_log_attr_init(&attr_log, attr.btf_log_buf, attr.btf_log_size,
> +					attr.btf_log_level, offsetof_log_true_size, uattr,
> +					&attr_common, uattr_common, size_common);
> +		err = err ?: bpf_btf_load(&attr, uattr, &attr_log);

Should the log_true_size offset be set only for user space calls? In v10
review, Andrii Nakryiko noted that log_true_size should only be set for
user space, not kernel space calls.

https://lore.kernel.org/bpf/CAEf4BzY3GA+860RODLaXqqO3j5AgJ24pmKU1yv3+gHJpy0DvNA@mail.gmail.com/

The current code does not check uattr.is_kernel before setting
offsetof_log_true_size. This could cause issues when bpf_sys_bpf() calls
__sys_bpf() with KERNEL_BPFPTR, as it would attempt to write log_true_size
to a kernel pointer instead of a user space pointer.

>  		break;
>  	case BPF_BTF_GET_FD_BY_ID:
>  		err = bpf_btf_get_fd_by_id(&attr);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24672239158
--===============1167874149647582553==--

