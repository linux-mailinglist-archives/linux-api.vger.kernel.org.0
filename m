Return-Path: <linux-api+bounces-5833-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CxcAT9qjWll2QAAu9opvQ
	(envelope-from <linux-api+bounces-5833-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 12 Feb 2026 06:50:55 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F6A12A7F3
	for <lists+linux-api@lfdr.de>; Thu, 12 Feb 2026 06:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A681E3020F03
	for <lists+linux-api@lfdr.de>; Thu, 12 Feb 2026 05:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39617B418;
	Thu, 12 Feb 2026 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uB85HGGP"
X-Original-To: linux-api@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4586329
	for <linux-api@vger.kernel.org>; Thu, 12 Feb 2026 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770875450; cv=none; b=SybeuT8p+uYwyK/DNINky7JozlBu7U2ezq66U26z2RXLFQJr+9EOPikfwoMcGYOvw/Uz7ur3m+3Nshb8qqVfcTx2EqcIBO8iVokEzMjj2Q2SJeHts6Xavv3dU6w3Io5dPHM9eBhxLpasfAQzPtkBvSVWZr0eZ37haZW4/vOvBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770875450; c=relaxed/simple;
	bh=4S/jXj+shLnKZ6JKcF8ffFmxUImpVQgZwGSRNFvx9es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mcdtk28fXXJj10wfC0DO0Jo5WgIzrBUpt4lk7PDMK1Mfiz4FXO5Vp0kM5U0LyxgpKzqf3fTxkhXiNQ5iCzamB9NmVemODN/wZ4P3UPTvau+psUsKGWi85Q5CtVadncpCAv9cDZA7nEb6QxthZ++/xH2tKhM2kX87TfGAf+i56nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uB85HGGP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb82cc40-e5c0-4f23-ad92-92633ccb2e0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770875436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rekBCk6mXK0MCMdqXLBM5+/XQA8lxIz8EKbCZ/pMd88=;
	b=uB85HGGPcU2moTAM9KK1Ggdr/x/vKUchcl13h/wF9IY5IUdxvjvXuIAHW0axQNfCuhXoEs
	s2LqrdNzKmwLlFOQerqoNtfV/56m7ImKCup274/n59sP1R5TeXtds/u0kuMJNHnvwe9fQ/
	k7zqtrOdL/u4a2B7G10/WN8A3QdywHg=
Date: Thu, 12 Feb 2026 13:50:20 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 4/8] bpf: Add syscall common attributes
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
References: <20260211151115.78013-1-leon.hwang@linux.dev>
 <20260211151115.78013-5-leon.hwang@linux.dev>
 <CAEf4BzbTtC19E_=RCk_KCjrOimbefhnXCEfURw4b+caxCY6SRQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbTtC19E_=RCk_KCjrOimbefhnXCEfURw4b+caxCY6SRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5833-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28F6A12A7F3
X-Rspamd-Action: no action



On 12/2/26 06:08, Andrii Nakryiko wrote:
> On Wed, Feb 11, 2026 at 7:13 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index e31747b84fe2..a2b41bf5e9cb 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -864,14 +864,43 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
>>         print_verifier_state(env, vstate, frameno, false);
>>  }
>>
>> +static bool bpf_log_attrs_set(u64 log_buf, u32 log_size, u32 log_level)
>> +{
>> +       return log_buf && log_size && log_level;
>> +}
>> +
>> +static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 log_buf, u32 log_size,
>> +                              u32 log_level)
>> +{
>> +       return bpf_log_attrs_set(log_buf, log_size, log_level) &&
>> +               bpf_log_attrs_set(common->log_buf, common->log_size, common->log_level) &&
>> +               (log_buf != common->log_buf || log_size != common->log_size ||
>> +                log_level != common->log_level);
>> +}
>> +
> 
> I'm not sure this check is doing what we discussed previously?... If
> log_buf is set, but log_size or log_level is zero, you'll just ignore
> log_buf here...
> 
> Maybe let's keep it super simple:
> 
> if (log_buf && common->log_buf && log_buf != common->log_buf)
>     return -EINVAL;
> /* same for log_size, log_level, log_true_size */
> 
> and then below just
> 
> log->log_buf = u64_to_user_ptr(log_buf ?: common->log_buf);
> log->log_size = log_size ?: common->log_size;
> 
> and so on
> 
>
> We can be stricter than that, of course (as in, all triplets have to
> be completely set in either/both common_attr and attr, and they should
> completely match), but it's just more code for little benefit.
>

We cannot mix fields across the two sources. For example, using log_buf
from attr together with common->log_size when log_size is zero would mix
the configuration and make the effective log setup ambiguous.

The intent is to align strictly with the semantics enforced by
bpf_verifier_log_attr_valid():

* log_buf and log_size must be specified together.
* A non-NULL log_buf requires log_level != 0.
* All values must pass basic sanity checks.

Given that contract, we should:

1. Validate the log attributes from attr and common independently using
   the same helper.
2. if both sides provide log buffers, require the tuples to match
   exactly.
3. select either the attr tuple or the common tuple as a whole — never
   mix fields across the two.

The patch below implements this by reusing bpf_verifier_log_attr_valid()
for both sources and resolving conflicts before selecting the effective
log configuration.
> 
>>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
>> -                     u32 __user *log_true_size)
>> +                     u32 __user *log_true_size, struct bpf_common_attr *common, bpfptr_t uattr,
>> +                     u32 size)
>>  {
>> +       if (bpf_log_attrs_diff(common, log_buf, log_size, log_level))
>> +               return -EINVAL;
>> +
>>         memset(log, 0, sizeof(*log));
>>         log->log_buf = u64_to_user_ptr(log_buf);
>>         log->log_size = log_size;
>>         log->log_level = log_level;
>>         log->log_true_size = log_true_size;
>> +
>> +       if (!log_buf && common->log_buf) {
>> +               log->log_buf = u64_to_user_ptr(common->log_buf);
>> +               log->log_size = common->log_size;
>> +               log->log_level = common->log_level;
>> +               if (size >= offsetofend(struct bpf_common_attr, log_true_size))
>> +                       log->log_true_size = uattr.user +
>> +                               offsetof(struct bpf_common_attr, log_true_size);
>> +               else
>> +                       log->log_true_size = NULL;
> 
> why not treat log_true_size same as log_buf/log_level/log_size? If
> both are provided, they should match, and then we don't have a
> possibility of inconsistency?
> 
log_true_size is different from log_buf/log_size/log_level.

It is not a regular attribute stored in either union bpf_attr or
struct bpf_common_attr. Instead, it is a user pointer derived from
uattr.user + offset.

As a result, the computed log_true_size pointer for union bpf_attr
and for struct bpf_common_attr will always differ, because they are
based on different base user pointers (uattr.user vs
uattr_common.user).

So unlike the other log attributes, pointer equality is not a
meaningful consistency check for log_true_size. The only sensible
rule is that whichever side provides the effective log triplet also
determines the write-back destination.

Thanks,
Leon

---

Based-on commit 19de32d4cb58 ("selftests/bpf: Migrate align.c tests to
test_loader framework").

From 32ec02c06d2abacbde17a45edbda46ef8a16fa2d Mon Sep 17 00:00:00 2001
From: Leon Hwang <leon.hwang@linux.dev>
Date: Wed, 11 Feb 2026 23:11:11 +0800
Subject: [PATCH bpf-next v11 4/8] bpf: Add syscall common attributes support
 for prog_load

BPF_PROG_LOAD can now take log parameters from both union bpf_attr and
struct bpf_common_attr. The merge rules are:

- if both sides provide a complete log tuple (buf/size/level) and they
  match, use it;
- if only one side provides log parameters, use that one;
- if both sides provide complete tuples but they differ, return -EINVAL.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  3 ++-
 kernel/bpf/log.c             | 38 ++++++++++++++++++++++++++++--------
 kernel/bpf/syscall.c         |  2 +-
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index dbd9bdb955b3..34f28d40022a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -643,7 +643,8 @@ struct bpf_log_attr {
 };

 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32
log_size, u32 log_level,
-		      u32 __user *log_true_size);
+		      u32 __user *log_true_size, struct bpf_common_attr *common,
bpfptr_t uattr,
+		      u32 size);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct
bpf_verifier_log *log);

 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index e31747b84fe2..47bf496b673e 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -13,17 +13,17 @@

 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)

-static bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
+static bool bpf_verifier_log_attr_valid(u32 log_level, char __user
*log_buf, u32 log_size)
 {
 	/* ubuf and len_total should both be specified (or not) together */
-	if (!!log->ubuf != !!log->len_total)
+	if (!!log_buf != !!log_size)
 		return false;
 	/* log buf without log_level is meaningless */
-	if (log->ubuf && log->level == 0)
+	if (log_buf && log_level == 0)
 		return false;
-	if (log->level & ~BPF_LOG_MASK)
+	if (log_level & ~BPF_LOG_MASK)
 		return false;
-	if (log->len_total > UINT_MAX >> 2)
+	if (log_size > UINT_MAX >> 2)
 		return false;
 	return true;
 }
@@ -36,7 +36,7 @@ int bpf_vlog_init(struct bpf_verifier_log *log, u32
log_level,
 	log->len_total = log_size;

 	/* log attributes have to be sane */
-	if (!bpf_verifier_log_attr_valid(log))
+	if (!bpf_verifier_log_attr_valid(log_level, log_buf, log_size))
 		return -EINVAL;

 	return 0;
@@ -865,13 +865,35 @@ void print_insn_state(struct bpf_verifier_env
*env, const struct bpf_verifier_st
 }

 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32
log_size, u32 log_level,
-		      u32 __user *log_true_size)
+		      u32 __user *log_true_size, struct bpf_common_attr *common,
bpfptr_t uattr,
+		      u32 size)
 {
+	char __user *ubuf_common = u64_to_user_ptr(common->log_buf);
+	char __user *ubuf = u64_to_user_ptr(log_buf);
+
+	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common,
common->log_size) ||
+	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
+		return -EINVAL;
+
+	if (ubuf && ubuf_common && (ubuf != ubuf_common || log_size !=
common->log_size ||
+				    log_level != common->log_level))
+		return -EINVAL;
+
 	memset(log, 0, sizeof(*log));
-	log->log_buf = u64_to_user_ptr(log_buf);
+	log->log_buf = ubuf;
 	log->log_size = log_size;
 	log->log_level = log_level;
 	log->log_true_size = log_true_size;
+
+	if (!ubuf && ubuf_common) {
+		log->log_buf = ubuf_common;
+		log->log_size = common->log_size;
+		log->log_level = common->log_level;
+		log->log_true_size = NULL;
+		if (size >= offsetofend(struct bpf_common_attr, log_true_size))
+			log->log_true_size = uattr.user +
+				offsetof(struct bpf_common_attr, log_true_size);
+	}
 	return 0;
 }

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e86674811996..17116603ff51 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6247,7 +6247,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t
uattr, unsigned int size,
 		if (from_user && size >= offsetofend(union bpf_attr, log_true_size))
 			log_true_size = uattr.user + offsetof(union bpf_attr, log_true_size);
 		err = bpf_log_attr_init(&attr_log, attr.log_buf, attr.log_size,
attr.log_level,
-					log_true_size);
+					log_true_size, &attr_common, uattr_common, size_common);
 		err = err ?: bpf_prog_load(&attr, uattr, &attr_log);
 		break;
 	case BPF_OBJ_PIN:
-- 
2.52.0



