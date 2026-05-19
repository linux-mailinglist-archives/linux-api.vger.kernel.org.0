Return-Path: <linux-api+bounces-6362-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LlVBFDZDGrhoQUAu9opvQ
	(envelope-from <linux-api+bounces-6362-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 23:42:40 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68550585435
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 23:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2313014BCB
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B5A3EBF03;
	Tue, 19 May 2026 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBBOp9lP"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D23B52F4
	for <linux-api@vger.kernel.org>; Tue, 19 May 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226957; cv=pass; b=rhCfYnxmOab1lVaKnOL2ozDNVuiadhE56Ym9Z7P8iKv1DVfA/a5m+D5RbqE4q2VBXkj7BE/ev52ZluP3zHXqyNSMLEl3tuUpPtTdhF6xiOWAoIAiUcI8elkqTTFlUFe5pK58z83m4ntzr8KEIa7j75647d9yFFHdiYPSF9Qycgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226957; c=relaxed/simple;
	bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuFOtf6bFbZ/1BxZpZO3f9PL3IDpUvSM7enV4S5zDfkpakJEIh/pvaGq6YpfjsDfb76TjxO2BhJLOJ0G+lSHJNm/haL5bp3BvC5ouLTkqWZlg3Supeil6ELucgiZhb3dmuQLnCxq7ikorHdQuVXVd39GB7N4foP2H+EaweX/Gy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBBOp9lP; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso302a12.1
        for <linux-api@vger.kernel.org>; Tue, 19 May 2026 14:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779226954; cv=none;
        d=google.com; s=arc-20240605;
        b=CwrNE8tGnkwFia4j4hmNvNCmDIzjbLsr3P6Z/6ojw6g9ap6Ytir3jwnvWAAkCcnwCt
         bgDki2IElA0EIAG5eCrsF5R6nxDFl4RGpqxNvhDl3WKkZWVDQuJfLFAY/qtr4GxkCQ/K
         QADsmA6dNxiVS8JMdVfRtiVKkt+mRRqeP5foCZJFi+OdWAR6a2ZmBeBXVIwxSM86PkWV
         nqBoIZya7R6Uloj46tsCdEvVUyVCN/rL4qpnZjGkm5XIbwoOK1mjqGhV8/0Gkwq0lWct
         BUdKrmX0UpgxU52DePInu3LGOfrbIA56uMYx9s6LzkzH/ZUxDWGpZFlGoi0Adkb5e7uc
         Putg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        fh=nhJQt+DNRWnre77sUJ9Lhnp2HvS94IqNum873yuKm40=;
        b=DayvpdXUqpeKiq+c/hs0wWnTaRtqIWTc/288ZRdF6TitYNxni3yuOoGO/3v2sSvqlO
         I4CbBf6hqgKl7y5yL9rimNFUSTLzqFoA8dlz5n/UnAQuyur8cOM6h7U6qu8EcCDtbpff
         6keXBnXErLw7sIrxMuTCLQFCA/GFtaZVf7QDEin/H5h87jG9ydZBK6ABd8b6aQ2tLW2D
         gbzWRanmxgJp/OrusFpG4VRb9LlW4FTUD0EXTRKijJahH5s+PIoUdWaWBLzVPf/MLYlf
         ZJnkWS3BmPnl1NFm951MDoC1L7kzyE5cMokpZh04aSHEFN56IoTu4vML1VFMyQeSE0gp
         C5TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779226954; x=1779831754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        b=cBBOp9lPxsBqzp5DiVVxXZDcRjTE3euWHcLy8b7vbCVmNAJKacI97hsJ3Vh0KDFaXt
         NXU/Zw17XqHcSHLDvSXAwaJJyllAMtOnzA54IEMDi5toSkc1FhEXHqZzqiln7NYZ4wvW
         lfDw4ZrKlWmzFMu6D/n8ftMX8TONAUMPAsEN31ppZN2D373vE0vjsNy/4phHOsAWuYNI
         nF/qzfTTzsfvL29YjAa8hB1+SvxRY6O7eKRjW3auOF834Bo2J3b1uCxJC4HpkvPM5oIs
         V7wciD7Ct1uavsVVCtQKUXyo51LalxiQasEvoLneaUrOkZFwJnRtJwnYl4KuZY4B5BFn
         MUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779226954; x=1779831754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        b=CulhMZ2z6wzZAbjwkHRU1jc93jktUW5OhfLJUmMugDpJNo1ZFfrRiiqqlS/HUtvDbi
         +/edvt5rNvUOjB23eFWUEEjPtugYuM98AfRbqUzUnLmaudKyrXufV4CzGzW750dUDWCb
         YMlcUinoCkXlZzy3D2z/rgydc5CedlmPpGv3p8Bq647ximCUVZm/+r5iTM2Rj2Fu+wOC
         0cbJMLdrBeamiMVZHXt/jPMW1CfNupqpZgFnD2F+YvhSi5Ck8KfdxP3jDI73eGwLwAM8
         TeR7ZzmKcEw2bZeOsIBgwKyOjWIOnJp34bbXvSMIsZ14tI6H+CtM53ZaDMK9Wi3Ks7Ck
         M4Kw==
X-Forwarded-Encrypted: i=1; AFNElJ/og9fnfMtkJSoxgTNhyC/B6TJMJFZq2ZpQooc1Kt7vIJKFl8QUQ+5meaKy0uLL4gzwvFC8g0LtEhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YL965ucsDagp4KIN4lInMQktKVdeVrn2PPt7nE/AyFn/x8we
	hkpd0rUaSjKE78UlYCEgVenCLQxsu/VxYt7j0obAHdFZ5a9GnQJMSCdhJw/VNoXpEYU+Ba9uj4c
	WipCCMqWAO+748GjX0ngZU2n93A3Hbh9n2Tx3NWGM
X-Gm-Gg: Acq92OHEDlj7XDNJoPEHd6CUo6lBUK2awf0nNNid17+oustqZ8iMJgxRxovs2QpF4y2
	ce/NkOzxXt3MljTwY2xzubFfyypWymnUHo08cYmgVVNVSM6bFObZHC9qUxW1Kwd7NLkY8Awm2FP
	BonkHPQhL5mXHqJd5naQ1UVuCYKoAeUAKmN+5VpC/wIBgy2Lo0xDbMnawDqokLpWIHOV8iwR1E0
	QK4COxVAii4I0bxVFoJHlb80IyR1VoSD00yboPkKtxwyFBwb7WrkRb7FbkVTvtt37HiylDf4zC2
	gKDBEXrCZs9yakiPr7paMDxA1KccstJOFx0RdxuPC/wAaQs=
X-Received: by 2002:a05:6402:20c6:20b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-684985e277fmr173995a12.3.1779226953632; Tue, 19 May 2026
 14:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
 <CAG48ez0KsuR5z4RDgxWPUoS8e_MJzF74RgFDJayohG48A_N0PQ@mail.gmail.com> <CAAmtCfMHqdWbYh-Hc5sGbOhXSM-aCA9G0-s64G8FTM+rGEV5RA@mail.gmail.com>
In-Reply-To: <CAAmtCfMHqdWbYh-Hc5sGbOhXSM-aCA9G0-s64G8FTM+rGEV5RA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 23:41:56 +0200
X-Gm-Features: AVHnY4KelXMX0Ox3UHP6DtmSDnRxPxmxV49wSNMKd-K67wpQhqz9skVmJZNDODo
Message-ID: <CAG48ez3u1OCx+zCWEs-_gowDmQ=KLbXO2xZ83LCZ1o1gxRT3Ww@mail.gmail.com>
Subject: Re: [RFC] TID v2.0: kernel module for cache-line zeroization against
 Flush+Reload (CLFLUSHOPT + LFENCE + REP STOSQ)
To: Ahmad Hasan <ahmaaaaadbntaaaaa@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel-hardening@lists.openwall.com, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6362-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 68550585435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:31=E2=80=AFPM Ahmad Hasan
<ahmaaaaadbntaaaaa@gmail.com> wrote:
> Thank you for your questions. I'll address each one:
>
> =3D=3D 1. Threat Model =3D=3D
>
> The target scenario is a same-machine attacker
> in multi-tenant/cloud environments where two
> processes share physical L3 cache.
>
> Example: a cryptographic service and a malicious
> process running on the same host. The attacker
> uses Flush+Reload to measure cache access timing
> after every encryption operation =E2=80=94 no physical
> access required.
>
> This is documented with real measurements:
> - Without TID: 78 cycles (Cache HIT =E2=80=94 key pattern visible)
> - With TID v2.0: 286 cycles (Cache MISS =E2=80=94 attack defeated)

So you're assuming that the cryptographic code leaks secrets through a
cache-based side channel? That would be a vulnerability in the crypto
code.

> =3D=3D 2. Why Kernel Module and not userspace? =3D=3D
>
> You are correct that CLFLUSHOPT does not require
> Ring 0. However, userspace execution can be
> interrupted by a Context Switch, which expands
> the timing window from 372ns to 36,640ns =E2=80=94
> making the attack significantly easier.

Why does it matter how many hundreds of nanoseconds it takes to wipe
the data from memory? You can also have a context switch directly
before you enter your cache-wiping syscall, or in the middle of a
crypto operation.

> =3D=3D 3. Why not add this directly to libraries? =3D=3D
>
> No major security library implements CLFLUSHOPT
> after wiping =E2=80=94 not OpenSSL, not libsodium, not
> glibc, not memzero_explicit. This gap has existed
> since Flush+Reload was published in 2014.

I don't think that's a gap, because the standard approach to
mitigating cache-based side channels such as FLUSH+RELOAD is to not
access memory at secret-dependent indices in the first place.

