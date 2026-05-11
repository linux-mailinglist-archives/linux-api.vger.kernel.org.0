Return-Path: <linux-api+bounces-6310-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLptJMYKAmqknQEAu9opvQ
	(envelope-from <linux-api+bounces-6310-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 18:58:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0C512D55
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 18:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AE1A3033CC5
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC043C074;
	Mon, 11 May 2026 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljDLeVW/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6723D4108
	for <linux-api@vger.kernel.org>; Mon, 11 May 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518402; cv=none; b=KVOYvFDq24HPyBSN5JMi7hAfP8X48f7PBgIpeQdd0zy4D/3dvSiS+FrGgbRVbjD32eFThEltJRlOcwKYZgs0Mvuz/Ji7aAQ5jAZxwjjjpp1ZjTgwVRpVWH+PJGDZ1adSwsibqc4bGhQQWK7KQ7hdvHgfiJQK/RXKCUb/gRUPMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518402; c=relaxed/simple;
	bh=NDr89ZHqjMmSAUjSSYDe/cY3Eiu1jte8P7RxS6azPjU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W0Wk2zUCGM6m3b4zm0U2DqG6QZ6vHVVxCvkWjFrylfpLLzYC9UMinAh8J/Iqct/NidyCyMpYvLueGGWxJ556Dr7UERcyELXlLCIeyt+iysGHh7IfqVrNrqeVIkYCLXS8gwgAIH9/zx1QeHvOqFvsvGTEvV1y/TdzETboJecTb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljDLeVW/; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-694891f8f62so2417322eaf.2
        for <linux-api@vger.kernel.org>; Mon, 11 May 2026 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518400; x=1779123200; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JavA89CInqrRT0axMkoFaX73nwP/5TwmJupoBxqRvFM=;
        b=ljDLeVW/UM0cgDttn8g3cTL06JrkMAr9PVMUHZx9PVOpYUxTGeS/Mi3jvg38dkJy45
         H+HsLHXM+MLVLybFkrw1EqYr53HcoUa3OEI9KsIbEeLB9EYzRGEuxMVzrTWaOGPVK6wu
         e69zT8HiyPrO1q6kPTejnZJ8gWq4SXVZeAvEoZCZbNsfMu2gC934/RPGwvaW2OjcREpC
         lOf1sujSjWYhwHEwz2JgzV1TeHIhCpCWUrFN2c8YljUpQtn8ABDCCut1FBnKr2i5SNTH
         +BnZuRBFDTtkFx876Q9gAMSHmjPi8YU+/IhwbMehVPyFsGOcLT0vRSIARBvS6MXqmWYZ
         oiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518400; x=1779123200;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JavA89CInqrRT0axMkoFaX73nwP/5TwmJupoBxqRvFM=;
        b=F6hS9Doc5hYeBnOoQtp9tlofjQEmCcT4UL+FPnCBA9FZ1zQhYZY22d+jn4orZC4Tzr
         8vbHq/LC5TKeer4v+RcfFcCtswEnz3DIX/XEsmTA+6VVDscaBkqZ68B/35l3XiQbmNDf
         tT5MdzsnOBR2sp1IiPGpgsQJGzd1ini8o9NZLCn2WW03dnTnLhDWG2gGUIgfYeEDkSgP
         YWmHjwejHHSFfWS7TdcGt7flv4jLSSa2b4jLR+RgpSjj15xwQ+A1eC98mPCB9DjIO/GQ
         MJ/bwOeUiPtqQ+PYW4JZ+DqjFhSE0wlFW2E9IL8zv9Y5Y2wF6/w0uZ26Rr6QNUC9lAzW
         VKmg==
X-Forwarded-Encrypted: i=1; AFNElJ/jDg4MSNwpVpGjbbUL1o3NqdUasx805jqaZf8si4xzmUt0YSW68FxZ96eYOqR8WuN4t7HTnhkVelg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywM3tuqHZVp6VdHPCeK+6z47aO+koHz5oeW9s/+WwEQjyricDL
	LMr7TFvv5V/9/BtpkKWWDaz8X4CGEEn+PlmtWLbowQ7SZBSH2spEYPdn
X-Gm-Gg: Acq92OFHI46ZkeyGTtMwW+1p15mh5R5519WAymNcTLZLVdw3WuVG3jo2sKHHGA4HuaJ
	Rs1ngfn3uU48/sJ5hmrqzR7OUOrpYdKz9KyZnVEvzD0XOCmgtN2bNSJM/tl1h6OXnRuXDTWI//C
	A/zdu1myDwQY4n+vQobCDcanxkJO3fxjeRikc2SR7JoKGpu1e4A9MjgVli1W034m9/Ldk1i2aID
	CSzoVK4yAmHhe/zeWDhNtVKxwAnmY3ofH/o79Z5iNvs+o3C2vNen1wl1EFNxufQXhA097ZPycin
	Va05Vw+KX7j4+Kk5RcEAUQYEDoNKZbZigleblvlL364yNu+Ir6/pGqtoLXR7Y9zuE8z9YAE9j+2
	Bu1CLwbTUyjdsXhQpvhbsywsZrdC0Nb38RHGEThnU9aX7ZjH3/CNKfTyQA6mQ/5X3JQ8bsCm3o2
	SdwNJvk/x3OHK7WgmdR2/0MGHTK2t0z4G/T6Q8faS86ekjAZ76b4L1Af7TCsl20piMEwGCfZTbG
	gPZiQuAhZQA2QhH/HglgUHSONK/Kia92jOBY6k=
X-Received: by 2002:a05:6820:986:b0:694:8b08:b916 with SMTP id 006d021491bc7-69b25c88aecmr8116691eaf.35.1778518399975;
        Mon, 11 May 2026 09:53:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c75d08sm6137740eaf.4.2026.05.11.09.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 09:53:17 -0700
Message-Id: <DIG05KI4QZ2H.3JE4OWSK6KC29@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
 <shuah@kernel.org>, <brauner@kernel.org>, <sforshee@kernel.org>,
 <yuichtsu@amazon.com>, <aalbersh@redhat.com>, <willemb@google.com>,
 <kerneljasonxing@gmail.com>, <chen.dylane@linux.dev>, <yatsenko@meta.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <ameryhung@gmail.com>,
 <rongtao@cestc.cn>, <linux-kernel@vger.kernel.org>,
 <linux-api@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v13 1/8] bpf: Extend BPF syscall with common
 attributes support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511152817.89191-2-leon.hwang@linux.dev>
 <810f123d14450d09d147d90dea25ddf5091e636542fcc5729d0594bfbd622757@mail.kernel.org>
In-Reply-To: <810f123d14450d09d147d90dea25ddf5091e636542fcc5729d0594bfbd622757@mail.kernel.org>
X-Rspamd-Queue-Id: 54E0C512D55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6310-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon May 11, 2026 at 9:19 AM PDT, bot+bpf-ci wrote:
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index f5639d5ac331..50055ab73649 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -936,7 +936,8 @@ asmlinkage long sys_seccomp(unsigned int op, unsigne=
d int flags,
>>  asmlinkage long sys_getrandom(char __user *buf, size_t count,
>>  			      unsigned int flags);
>>  asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned=
 int flags);
>> -asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned =
int size);
>> +asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned =
int size,
>> +			struct bpf_common_attr __user *attr_common, unsigned int size_common=
);
>>  asmlinkage long sys_execveat(int dfd, const char __user *filename,
>>  			const char __user *const __user *argv,
>>  			const char __user *const __user *envp, int flags);
>
> [ ... ]
>
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/b=
pf.h
>> index 677be9a47347..16ff0968fc21 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -994,6 +994,7 @@ enum bpf_cmd {
>>  	BPF_PROG_STREAM_READ_BY_FD,
>>  	BPF_PROG_ASSOC_STRUCT_OPS,
>>  	__MAX_BPF_CMD,
>> +	BPF_COMMON_ATTRS =3D 1 << 16, /* Indicate carrying syscall common attr=
s. */
>>  };
>
> [ ... ]
>
>> @@ -1500,6 +1501,13 @@ struct bpf_stack_build_id {
>>  	};
>>  };
>>
>> +struct bpf_common_attr {
>> +	__u64 log_buf;
>> +	__u32 log_size;
>> +	__u32 log_level;
>> +	__u32 log_true_size;
>> +};
>> +
>
> Should log_buf use __aligned_u64 instead of plain __u64?
>
> Looking at other pointer-bearing fields in the BPF UAPI, they consistentl=
y
> use __aligned_u64. For example, the existing BPF_PROG_LOAD log_buf in uni=
on
> bpf_attr is declared as:
>
>     __aligned_u64 log_buf;  /* user supplied buffer */
>
> The __aligned_u64 attribute forces 8-byte alignment on all architectures,
> including 32-bit systems where native unsigned long long alignment is onl=
y
> 4 bytes. Without this attribute, struct bpf_common_attr will have differe=
nt
> layouts between 32-bit and 64-bit ABIs:
>
> - 32-bit: 20 bytes, 4-byte aligned
> - 64-bit: 24 bytes (4 bytes of tail padding), 8-byte aligned
>
> While the current __sys_bpf() implementation with bpf_check_uarg_tail_zer=
o()
> and min_t() capped copying handles this gracefully, deviating from the
> established BPF UAPI convention could create problems for future extensio=
ns.
> If another __u64 field is added later, the inter-field offsets would dive=
rge
> between ABIs.
>
> Would it be better to use __aligned_u64 log_buf to match union bpf_attr a=
nd
> preserve identical struct layouts across 32/64-bit ABIs?

bot has a point.

pw-bot: cr

