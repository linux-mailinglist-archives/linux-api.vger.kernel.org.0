Return-Path: <linux-api+bounces-6124-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHsOG11g6GkKJwIAu9opvQ
	(envelope-from <linux-api+bounces-6124-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 22 Apr 2026 07:45:01 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD89144225D
	for <lists+linux-api@lfdr.de>; Wed, 22 Apr 2026 07:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 825D4300DD54
	for <lists+linux-api@lfdr.de>; Wed, 22 Apr 2026 05:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE923242D4;
	Wed, 22 Apr 2026 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="te9p3ndQ"
X-Original-To: linux-api@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C1E314B62
	for <linux-api@vger.kernel.org>; Wed, 22 Apr 2026 05:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836698; cv=none; b=pFcTR/EE3RJ/he7qa3LINvtmxZugEBWjJ4loWlILHoaDiklMvs4va9T1RibbBc52GsfMrE4AVytzjp60S8p4eAUySdIZJF2amvJOUeY1NsSJDCN7zHYMkWaLrMMmmCNN30G6GK6k2vyoRNhQq7LdIR/dRbpAc7eXUDlzG7idxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836698; c=relaxed/simple;
	bh=q8QsP94Tuz9LxVQKLJFRDLizKYKNuCgNutEHx/2mtpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4+DyteU/EqKJqXBXlCLPVnwXGi+hMHmAb/DW0EcDjkp+DIsmuuKlCpmmwM15mzNwkJaSILWPt8mYIyEAg5Fj8kUzzzKKuh9dQ38cYBxIeerzWq0ZJfQJcySewkgJ3W/7rmdYwLIqqUyDSV5MjvyjBWmSzifBBouEDtdHso4Up8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=te9p3ndQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776836684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DphR6/tgae6M2+ZT3YzkrNihU4uPDcwRHKi0iD5AePY=;
	b=te9p3ndQEZOmoxo4uyjWj7rEinR0W6tTJtaQx8lMoUjgOSfnH93g5rOzHle/5MpiLTJ4kW
	mQL33QnrNynSUO+ke82lLm++hTuXXxvPkf3sMC/2wrxfirCQKSN0T4Xwfz6ps9B46Uwb7C
	VyL+giOoxHjpsdMGIY6tO5+zZd4SzZU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: Leon Hwang <leon.hwang@linux.dev>,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	brauner@kernel.org,
	sforshee@kernel.org,
	yuichtsu@amazon.com,
	aalbersh@redhat.com,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	chen.dylane@linux.dev,
	yatsenko@meta.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com,
	martin.lau@kernel.org,
	clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v12 6/8] bpf: Add syscall common attributes support for map_create
Date: Wed, 22 Apr 2026 13:44:27 +0800
Message-ID: <20260422054429.389475-1-leon.hwang@linux.dev>
In-Reply-To: <caa1b9f532b97e8cbcf9b2c00fc5d39d038066d08993ab4c12bba5a6cf971528@mail.kernel.org>
References: <20260420141804.27179-7-leon.hwang@linux.dev>  <caa1b9f532b97e8cbcf9b2c00fc5d39d038066d08993ab4c12bba5a6cf971528@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-6124-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: CD89144225D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 14:56:33 +0000 (UTC), bot+bpf-ci@kernel.org wrote:=0D
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h=
=0D
>> index dbe321aa8591..34500f81db6e 100644=0D
>> --- a/include/linux/bpf_verifier.h=0D
>> +++ b/include/linux/bpf_verifier.h=0D
>> @@ -710,6 +710,9 @@ struct bpf_log_attr {=0D
>> int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,=0D
>> u32 offsetof_log_true_size, bpfptr_t uattr, struct bpf_common_attr *comm=
on,=0D
>> bpfptr_t uattr_common, u32 size_common);=0D
>> +struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *=
attr_log,=0D
>> +						  struct bpf_common_attr *common, bpfptr_t uattr,=0D
>> +						  u32 size);=0D
>> int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log);=0D
>>=0D
>> #define BPF_MAX_SUBPROGS 256=0D
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c=0D
>> index dffe3a0180a7..5a977a52ef61 100644=0D
>> --- a/kernel/bpf/log.c=0D
>> +++ b/kernel/bpf/log.c=0D
>> @@ -860,6 +860,36 @@ int bpf_log_attr_init(struct bpf_log_attr *log, u64=
 log_buf, u32 log_size, u32 l=0D
>> return 0;=0D
>> }=0D
>>=0D
>> +=0D
=0D
NIT: should drop this dup blank line.=0D
=0D
>> +struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *=
attr_log,=0D
>> +						  struct bpf_common_attr *common, bpfptr_t uattr,=0D
>> +						  u32 size)=0D
>> +{=0D
>> +	struct bpf_verifier_log *log;=0D
>> +	int err;=0D
>> +=0D
>> +	memset(attr_log, 0, sizeof(*attr_log));=0D
>> +	attr_log->uattr =3D uattr;=0D
>> +	if (size >=3D offsetofend(struct bpf_common_attr, log_true_size))=0D
>> +		attr_log->offsetof_true_size =3D offsetof(struct bpf_common_attr, log=
_true_size);=0D
>> +=0D
>> +	if (!common->log_buf)=0D
>> +		return NULL;=0D
>=0D
> Does this skip validation that bpf_log_attr_init() performs?=0D
>=0D
> The sibling helper bpf_log_attr_init() validates struct bpf_common_attr=0D
> fields via bpf_verifier_log_attr_valid() unconditionally:=0D
>=0D
> kernel/bpf/log.c:bpf_log_attr_init() {=0D
>     if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, comm=
on->log_size) ||=0D
>         !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))=0D
>         return -EINVAL;=0D
> }=0D
>=0D
> This returns -EINVAL for combinations like (log_buf=3D=3D0 && log_size!=
=3D0)=0D
> or (log_buf=3D=3D0 && log_level!=3D0), enforced by:=0D
>=0D
> kernel/bpf/log.c:bpf_verifier_log_attr_valid() {=0D
>     /* ubuf and len_total should both be specified (or not) together */=0D
>     if (!!log_buf !=3D !!log_size)=0D
>         return false;=0D
>     if (log_buf && log_level =3D=3D 0)=0D
>         return false;=0D
>     if (log_level & ~BPF_LOG_MASK)=0D
>         return false;=0D
>     if (log_size > UINT_MAX >> 2)=0D
>         return false;=0D
> }=0D
>=0D
> When bpf_log_attr_create_vlog() returns early because common->log_buf =3D=
=3D 0,=0D
> these four checks are skipped entirely. When common->log_buf !=3D 0, the=
=0D
> checks run later via bpf_vlog_init().=0D
>=0D
> This creates an ABI validation inconsistency: BPF_PROG_LOAD and BPF_BTF_L=
OAD=0D
> reject (log_buf=3D=3D0 && log_size!=3D0) with -EINVAL, but BPF_MAP_CREATE=
=0D
> silently accepts it. Userspace passing the same invalid attribute=0D
> combination receives different results depending on the syscall command.=
=0D
>=0D
> Should bpf_log_attr_create_vlog() call=0D
> bpf_verifier_log_attr_valid(common->log_level, u64_to_user_ptr(common->lo=
g_buf), common->log_size)=0D
> before the early return, and return ERR_PTR(-EINVAL) on failure?=0D
>=0D
=0D
It was intentional.=0D
=0D
Like the bpf_log(log, ...) use in this patch, if log_buf is not provided,=0D
there's nowhere to store the log msg. Thereafter, no need to alloc the log=
=0D
object.=0D
=0D
It seems cheap to alloc the 1KiB+ log object. So it would be fine to drop=0D
this early check, and let bpf_vlog_init() validate them instead.=0D
=0D
Thanks,=0D
Leon=0D
=0D
>> +=0D
[...]=0D

