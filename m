Return-Path: <linux-api+bounces-6122-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DlpN6xP5mkDuwEAu9opvQ
	(envelope-from <linux-api+bounces-6122-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 18:09:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B342F13D
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 18:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 683CF33C1C8E
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE551332919;
	Mon, 20 Apr 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdRtxufN"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4364332634;
	Mon, 20 Apr 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696993; cv=none; b=Y+6kq0+XtIG469woSEIRW01pCcUcPleWPI8aD8HR8U7pHi4sAF3s4xyTfDFjrClgFDAOuxoabbQZX/vdreMKAhMIXcOjBCUwH7Tg3t9KkGNBHkUgjbdq45mMEMbB3bFxPczoxZP6EE/7S/Bvv2YS8CO01jxWGA+MRj+NkuytHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696993; c=relaxed/simple;
	bh=BxVclgv4fc4tD7hUacAByzpX6JbbELQlnyuhZywzNJ0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=P3GMSR0v1+aN3nXRS2iQ0ltKTCVb6h0lzqQ8dnb1sE8C2l9DcqT0O9Hv1gZ9Hbpy87iAEU0AKlaIkYyQPmOUvG9tANyYP4Ezgs3iQXj6pp+lhnRJiW355NIH0XLRrh8Yfwt96b11/lULFJlwC4+N7xYQwYxu7t/xmNhTNV/RyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdRtxufN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A51C2BCB4;
	Mon, 20 Apr 2026 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776696993;
	bh=BxVclgv4fc4tD7hUacAByzpX6JbbELQlnyuhZywzNJ0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IdRtxufNSxbhzokTHxkwMcjw7eNlzIdX1vu598uAFmKZ94sVOZMu5uW+Fc7p0jhkK
	 O42dLY7pwTDiaF2fyJWSN4W6dfFfmsSpyK0t2GpcypYeVND9gxbF9u/JLwXwOs0GNG
	 algykwyMTFOXTX0oHT0z3mP9KE4KDNL3yoNioQ2jgYyJl1TOpi+ASVQNOxyxl/NA5N
	 a7YIoKGe3eicLwAEolSnbq4w3QOBPGQrEViTC4wGhYO5weuENK1HpolBC3tHRSIc13
	 D/ia0TxTPKRT8EYSoUY1GukZz5LzbGz6iigAZKo8DRP9MX+WIHS7IcQLuqpQ83Apdl
	 eyuiQpa8ZKdtA==
Content-Type: multipart/mixed; boundary="===============3502908310941193361=="
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <caa1b9f532b97e8cbcf9b2c00fc5d39d038066d08993ab4c12bba5a6cf971528@mail.kernel.org>
In-Reply-To: <20260420141804.27179-7-leon.hwang@linux.dev>
References: <20260420141804.27179-7-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 6/8] bpf: Add syscall common attributes support for map_create
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,brauner@kernel.org,sforshee@kernel.org,yuichtsu@amazon.com,aalbersh@redhat.com,leon.hwang@linux.dev,willemb@google.com,kerneljasonxing@gmail.com,chen.dylane@linux.dev,yatsenko@meta.com,memxor@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,linux-kernel@vger.kernel.org,linux-api@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 20 Apr 2026 14:56:33 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-api@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6122-lists,linux-api=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 590B342F13D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============3502908310941193361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index dbe321aa8591..34500f81db6e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -710,6 +710,9 @@ struct bpf_log_attr {
>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
>  		      u32 offsetof_log_true_size, bpfptr_t uattr, struct bpf_common_attr *common,
>  		      bpfptr_t uattr_common, u32 size_common);
> +struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
> +						  struct bpf_common_attr *common, bpfptr_t uattr,
> +						  u32 size);
>  int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index dffe3a0180a7..5a977a52ef61 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -860,6 +860,36 @@ int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 l
>  	return 0;
>  }
>
> +
> +struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
> +						  struct bpf_common_attr *common, bpfptr_t uattr,
> +						  u32 size)
> +{
> +	struct bpf_verifier_log *log;
> +	int err;
> +
> +	memset(attr_log, 0, sizeof(*attr_log));
> +	attr_log->uattr = uattr;
> +	if (size >= offsetofend(struct bpf_common_attr, log_true_size))
> +		attr_log->offsetof_true_size = offsetof(struct bpf_common_attr, log_true_size);
> +
> +	if (!common->log_buf)
> +		return NULL;

Does this skip validation that bpf_log_attr_init() performs?

The sibling helper bpf_log_attr_init() validates struct bpf_common_attr
fields via bpf_verifier_log_attr_valid() unconditionally:

kernel/bpf/log.c:bpf_log_attr_init() {
    if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, common->log_size) ||
        !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
        return -EINVAL;
}

This returns -EINVAL for combinations like (log_buf==0 && log_size!=0)
or (log_buf==0 && log_level!=0), enforced by:

kernel/bpf/log.c:bpf_verifier_log_attr_valid() {
    /* ubuf and len_total should both be specified (or not) together */
    if (!!log_buf != !!log_size)
        return false;
    if (log_buf && log_level == 0)
        return false;
    if (log_level & ~BPF_LOG_MASK)
        return false;
    if (log_size > UINT_MAX >> 2)
        return false;
}

When bpf_log_attr_create_vlog() returns early because common->log_buf == 0,
these four checks are skipped entirely. When common->log_buf != 0, the
checks run later via bpf_vlog_init().

This creates an ABI validation inconsistency: BPF_PROG_LOAD and BPF_BTF_LOAD
reject (log_buf==0 && log_size!=0) with -EINVAL, but BPF_MAP_CREATE
silently accepts it. Userspace passing the same invalid attribute
combination receives different results depending on the syscall command.

Should bpf_log_attr_create_vlog() call
bpf_verifier_log_attr_valid(common->log_level, u64_to_user_ptr(common->log_buf), common->log_size)
before the early return, and return ERR_PTR(-EINVAL) on failure?

> +
> +	log = kzalloc_obj(*log, GFP_KERNEL);
> +	if (!log)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = bpf_vlog_init(log, common->log_level, u64_to_user_ptr(common->log_buf),
> +			    common->log_size);
> +	if (err) {
> +		kfree(log);
> +		return ERR_PTR(err);
> +	}
> +
> +	return log;
> +}
> +
>  int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log)
>  {
>  	u32 log_true_size;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24672239158
--===============3502908310941193361==--

