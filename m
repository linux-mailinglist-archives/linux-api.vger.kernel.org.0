Return-Path: <linux-api+bounces-5802-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNtULciog2m2sAMAu9opvQ
	(envelope-from <linux-api+bounces-5802-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 21:15:04 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43FEC622
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 21:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FACA3013027
	for <lists+linux-api@lfdr.de>; Wed,  4 Feb 2026 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158193D4114;
	Wed,  4 Feb 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqs+z+n5"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC33A1E96
	for <linux-api@vger.kernel.org>; Wed,  4 Feb 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236100; cv=pass; b=WIQju7Zowx677uW6GyO0fdhF5zrPObZrQWIHRT3l1thip3IKQ4vkhuWz2PJNq/cG3GEsG8eabyrV1/tHIZq8UOuv3YMjWxmb60VifR0gmmcxM+GI4n9A4OQGTUM8AHO1iD2Ab0PID8DrkA9kfMvxrMllAPZMLKc6fBqop1xYBdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236100; c=relaxed/simple;
	bh=3XOUAy3XIIn08AGjDN/QS6JH3XCKP3Voe4vAPQObQ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsOZckkbSX1uucm4wL3y/OznqLHiGHNrgkwhcV3EuHn7nWLoV2CUOKJOFW26JZD/obGj6O5txFQ1rnb2G/VQvuGiXevC0ZPf6DDpuyaw76LrUpINEOk1NghIvoFk4fdHtlUQmkQ4Yf/w/n49RZ45g9oySNqhPbsdDcQIjubiASs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqs+z+n5; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-435903c4040so198764f8f.3
        for <linux-api@vger.kernel.org>; Wed, 04 Feb 2026 12:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770236098; cv=none;
        d=google.com; s=arc-20240605;
        b=XnKXqwzWSUYvjQjnzVKzY/pNOpFGpkw7bj+AMhozyAP22y7HjzZfzsQXzHUS4dXeHk
         CDJlbqiXdrHDK7yDovTKSnci+0Hef4Zm15gBF0EFq3Nt972qNvaGdsrMtojBlI3kStqn
         w3vh0qSYeWqeA2U0ufoxeHl7NhlCOybzUmjWLoI0rEcRxnrsoiTWxraUDjhrYJl0gWmm
         cRhW16P/fDLd8AJL4sK12zA3LFx8Fxgk6bydgmf/3e1+0fHhJWuoVb51pkb/E5cA1p9U
         yiJHIqg6HoyvsE4eAP8XACuDBfWIehIfGt6m5fL/5uqRrEtOGgYQX6XBCi87wWlJosAB
         N6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mkiN7mFgrITdHV9O50DWF0sIOrkOU+OBcsroscUTkI0=;
        fh=HRp8u+mgZ8k5JwkxEbqX4E/BfNTHL0hakh5pYFXcxpg=;
        b=Vg7MRoHSG1tCWv9Kz1n9x4G1NkVFISzM1scAup8bgHsnLXi10u08TG1qoBLHthUzyK
         vaCKHF3vZBuHAwxY1uRjh178IMGkgl9znVprvsUoYOn0yq3NIHIDmGpWn8FUzLoBoyNS
         3YNp4tx8gzE0e4pzcJtXRs2CMPAAPdP1BvQFzD9tlObz3ZXE/vlWoCIkVOq5eKK3IbqO
         Efg19B8SoRoF/Jzim+racjqLtzP22tEkKa3LMrhoaHXns6p+emzdmQhIaOH27IvFBSmX
         ahvW3rGKg9e/hx9jG3JAJfxsk12jHlx34M+fuhElzRYDYNZkabE5HUW8S/U1lioB5zyl
         5Pzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770236098; x=1770840898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkiN7mFgrITdHV9O50DWF0sIOrkOU+OBcsroscUTkI0=;
        b=Mqs+z+n5WxBiO7kMqf1V6wR2WYuYti6pChwKSKEIYJB8cb6dSpRXg0lPgGsj6b519z
         27iO4sSJfZat4DWYDVRneTTbCo0w/ZkfQZ8jGZnrzpVwD4C2e1K2VSVM0fj92KbtdvLw
         YV71YM6cWLMyI5QUTSGtP5K+M1Atrz6TZlyBFmOsC2jB2+Da/c+Qgnj29PPytFUVJkih
         Wp4CXgnIH6hA6d3p8/i4VAP4nZKHblZ6rK4ScxSmfRrxm3OZdlHSEYEWpzXovSUNEeOx
         p40y8b5OBjAoC4EJPz3PrNImtf7NI8j87+KpeGYRsVmdIPGewi4BKtGk6A+f1ubqjXgb
         B2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770236098; x=1770840898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkiN7mFgrITdHV9O50DWF0sIOrkOU+OBcsroscUTkI0=;
        b=gwZgMHR56pKdHoUC4gPOqrwqv8B2/vHR6Qa07roQK/Th/EAdLeyC8MsvdGDqPq1MaL
         WZfcIgSHm7y+/eopi8fkX15re6GxH3xEclyZ95bSSRBNuwXR5e5ICtPo8u/bqAQkX0vE
         2svlGJq8eIbiLjYLMOEwl0T/WCWjjDYcfCjgc1wx7gVhpJ12xAn8bpO996NX914uHpWf
         qicxM7sWvkGwSxEMuMQaJY9cUbZd1Epi+fSyBA11+cnwwtKIvAsjWC5dkrk1cuVAVyD6
         TxB1K3gfLe3rUa+vxF/dS1ZjEisYs1AB77AnvoX0u76nJkwWkamsTdGj/wUGeqhj5yLd
         3JzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxaMrT7S2WJu0RoIHE/44o1BsD+5/jv/lZaHfB/OofaG/1gERc70zS0bXxqUvy/q749NGsvWYmODg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1hEOSOOTYn4wgCS6nuo8NL5Ybd7gDP8xhf78eFmb/yU531xg
	JvdFEN1ZGFDDF3X1oxuCPAF0Aj2ov/6/mEAI37PX5WP35G/3IMKJspHIE0bY6ZzgPqT+0j7pmVe
	A5CS2+RP4EaxJc08Wkjjox4+PniXSKtI=
X-Gm-Gg: AZuq6aJwQMElf++EOjdAi65RN/ErGDUHd0NSojnzs8a7xamJoheMOC8bLrRHL8rfT/b
	kct/psu3Era23UBMICFA2y54Tt/lue3iqP+F5HrhimplKLrbecpsHY4Ca2QsB/3wvQugdUogE9z
	uWj71DGQTV5gUHmuxlVpIjwSYiVY9+THwqMZGxZ3ar/pN1CJlBgLMGPWyytEAVzLILCNHaQvhjR
	Ii/lx/85Oi995Qn4xEVsVL2skoh7neSSjFA5VLjXYgeBD8cyHv1HKNm4GkuquhRxqASdpWnqNdS
	PbSTJPwLZXKs8y21wUoAJUt6Ic4eUjmsbrn2QFEBsreqc4FMY6tRkdwKna1FZ6fuSt0Iu9xDUqB
	xQzY+RxIj+yDuTg==
X-Received: by 2002:a5d:64c7:0:b0:431:488:b9bc with SMTP id
 ffacd0b85a97d-43617e351camr6268378f8f.10.1770236097724; Wed, 04 Feb 2026
 12:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-10-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-10-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Feb 2026 12:14:46 -0800
X-Gm-Features: AZwV_Qj_M0j2QuFHcqb1uasQT0CwO6eJFnjOQYZ1YB11d59OLhbMlJUDF0EXYlY
Message-ID: <CAADnVQLXWQ8Miq2WBoXRDsEVP1QPwk=a5=Rj_uPN+9qKHZZmZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 9/9] selftests/bpf: Add tests to verify map
 create failure log
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5802-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7A43FEC622
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 6:43=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> +
> +#define BPF_LOG_FIXED  8
> +
> +static void test_map_create(enum bpf_map_type map_type, const char *map_=
name,
> +                           struct bpf_map_create_opts *opts, const char =
*exp_msg)
> +{
> +       const int key_size =3D 4, value_size =3D 4, max_entries =3D 1;
> +       char log_buf[128];
> +       int fd;
> +       LIBBPF_OPTS(bpf_log_opts, log_opts);
> +
> +       log_buf[0] =3D '\0';
> +       log_opts.log_buf =3D log_buf;
> +       log_opts.log_size =3D sizeof(log_buf);
> +       log_opts.log_level =3D BPF_LOG_FIXED;

Why? Which part of the test needs the log with this flag?

