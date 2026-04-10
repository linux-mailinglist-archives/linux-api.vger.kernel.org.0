Return-Path: <linux-api+bounces-6077-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH+kFaap2GkhgggAu9opvQ
	(envelope-from <linux-api+bounces-6077-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 09:41:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A13D3771
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 09:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98A943012B77
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52A3A168B;
	Fri, 10 Apr 2026 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GST7h6Cm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49539E164
	for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806871; cv=pass; b=MdLj7m8qdt/xk2O2fkp8aAZ5US6Ck0tmxE+FPAoqgQeu/DAv/5+zzYdJdePzAqowOhIy/dHP9rp8EizfQREmQBW1WC4KQAYvDKIL2R6Phdd1ZysOXjnR1eq/HDm1noYlJtYTnJAEuh4kZKdXzxeIjlm5nnN/kXbr50+wsnvDZgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806871; c=relaxed/simple;
	bh=IDdcP5PunTf9H+4SJfKGmj4edsKHuDSLPd+6NKyAilM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTRIz+ry7xmAD8iE9aZClhk0ItxoFQAA9DWvksy5Vh36lFkyQdFUindz9gRM3Nu0z4V+i6dj854iIMIrEEOJvl86N+pdqOuXTbfd4WuTGDFT1EDMaNby/GVMQkDNEw10D9C3jZW6kZNisHeHeqApFo2RqXPB0xm0wpeUQLxc+7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GST7h6Cm; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82d561b3689so797718b3a.0
        for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 00:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775806869; cv=none;
        d=google.com; s=arc-20240605;
        b=Ru+VhaDPKUEFTrkyxaqjfcLz5oKGqUjsVSS3G+sXAdQxDtlxifdxCpMh7PIFQjTFNe
         nco3iTbMt+hvOnmKc0pnQNUsIL7Y7UroQiZoHMsNYJhDOaJ5ENogO3HHU81xca4xzPnS
         xxUpw1LkX98+8pB3sxjzKgBbmefOxT0/EATrubIqtD+MevZEIWYwFPkXCI70HGp1djNl
         EDgQ/E/pLOrHn/vhc7Z2GdqCCh08pn9wu4H411xP1AqZZkHK1aI1WXtoHF19xaVn45R0
         MGUlp1Bgg1QCkYTzbKVmQx832QfO6KnvjRe3goOmv3SphFkz1MriiVraI5HCUrKpBoll
         ByFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VyUDLe9op6fro+UTV2QPNy+ybN5BymQB+k0QJvZZ1Z0=;
        fh=qPeltlzi9Kl5HPw8EigX72J8JAlLaU0lE1TVfVULd5Q=;
        b=Z4F0GiAGnZ2DquwUbyviudwokueI9ho7lceUnmWo1O57Mhm3eTDxLjrZXblAGHw581
         lVc/vOtPgCCuhFn0FpTasDeGaMZGBGMptLXuNRpp5tETYfH1U3rz3ckg4xB5o429NDLv
         bY0UuV1Tg8YcMqUTVNtrKhxnorq+GzFBjHUdmmjdc2KfVnciRC8UWgT+hgsvWuLPldoo
         DGtzSVfYpIq+c4+y91yRMic6VeqRanOfn/RXfE6Ww9wlNwC443t4DH9m7ep1DJYVPSRE
         mWC1ArDxALsLUt7uxOlLYrmq8ZtI+XIqoFn5Z2hdSxF/JlyYnfbhxUrjj+58A5abRutf
         f4eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775806869; x=1776411669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyUDLe9op6fro+UTV2QPNy+ybN5BymQB+k0QJvZZ1Z0=;
        b=GST7h6CmGd9Vskhfb3E5VH7x2RypNzKRMUN6oKg+fzHYWKzGqteRGVxjd7POFM5ci9
         Lzv8Sr4pNDKNZV68zUOM8T0S1+r6yKsqudBYM8I/KyV/PA+eF3wCdhbHl9vHNECCNteg
         C0gjS/xM4TtW2stqphc9Ua2qBfDev5VuPTa4xH/TfwPQ8v0IigGcqhYcmKPCrd11UHfk
         BQ2h2WOtm9L+LyubNPz5wxTRfDu1WIOVHQBwc/qgGu5nrnanm645vcFzLOGC7FM+BaR1
         LdJYbwVcEBFpw0E4HzPCDEq8cxGeBl/e/ew7nt/oLfMeBzmtnAurwUcItp+bXbHG4qsM
         NW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806869; x=1776411669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VyUDLe9op6fro+UTV2QPNy+ybN5BymQB+k0QJvZZ1Z0=;
        b=KOOGd9DIwGhmb563sAfGMO0Jdsj5937DBUe8VRAbEO6olbTWpHT56Q3TyJbWaQ+SeV
         V5HlQEVltBbEmAr7pQOA5/a2OlDhF0FQJWZII7K7dUt4gl5Vj8+IRSZdS+ItJ6+E20n+
         ISeke3QDRaK9QF4QuGnbMkigjit6cmeBwtXEeR6amrWQQ0pDOSwruffrtsZU0weqw3qH
         DFSSauOpeR9g3Yh4IXjY6iyLpD4rHSBH6EYsJlg9tWslXAZgac16oFSczbVPsDeF3L2J
         Q4vHbd05ifTgnO9G4kH4gFAbBLciHAVqSpDk5M7WeSZ5jc5+YaQoVRSoAEhyeDH1RCJd
         vF+w==
X-Forwarded-Encrypted: i=1; AJvYcCUmiBKDFoiToEaCy5XuD7IMpKY3yZQFuuxEX1w9mN8nMHXHj2ijnDZLwKhaqk+C68rvVIyRJ6JHuLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63Hj31Mwz2i1au8aMfMI3Uy3Sk4uriT3+BszOi1B++UvsmcBu
	BLoXWSeO3vrlSYnh9s//KHQ+n0SuWGd5fT/XhoQWyPwZqZurYKqNf4QrhD5cYGv5FHl04UYMQWZ
	BOvHgO/YoiIq/zkbPpUZ7h6zBonBHZl0iVEFgW5a79A==
X-Gm-Gg: AeBDietubFvLRXMksAl7TRG+RP0iXhNWM1xOrKn0x0UFxNKUlCZNbW4rFNccZsaxAHW
	DCAd6uxBIrLCoMvt9HRqtpvPJqO0e6hNBkN+jF9JvnBz/AnCJqD27SZcRZRtWoCGyDPp/dEp5PP
	1z3XkUPhJNc9UVIeFNvSs2vHLF9EARHkmNJJLJqTIItUuIlT0EOHqEYaPpdJgnDWVWQwoPP2BOe
	O8rf1mLX6UGFT8HGKrlpsDmMb0Mm2JAPFMduBz0kQjqAejo5/cT6E3+SRUSdnZdNn80bg0Lcr9B
	nwtUfysq
X-Received: by 2002:a05:6a00:4c1c:b0:82d:2a2:1b57 with SMTP id
 d2e1a72fcca58-82f0c2de0d6mr2666948b3a.51.1775806869429; Fri, 10 Apr 2026
 00:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMe9rOrk20jCXO_Bun4LK6M3fd_8HzEtAu94FW+-xSkwNiOt7w@mail.gmail.com>
 <lhupl47e0lc.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhupl47e0lc.fsf@oldenburg.str.redhat.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 10 Apr 2026 15:40:30 +0800
X-Gm-Features: AQROBzCc13uK7--1sLG2PO89IiJKd69sYH7-2kYxtSyBLGpYrIlbJBmZfwE8lE4
Message-ID: <CAMe9rOpf2f8u4ng+nnaqEYB3bUvvVPu3mGv7bt=5xfzDHcMOFg@mail.gmail.com>
Subject: Re: Avoid reading /sys/kernel/mm/transparent_hugepage/?
To: Florian Weimer <fweimer@redhat.com>
Cc: GNU C Library <libc-alpha@sourceware.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6077-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sourceware.org,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hjltools@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F28A13D3771
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 3:28=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * H. J. Lu:
>
> > To enable THP segment load, ld.so opens and reads 2 files under
> > /sys/kernel/mm/transparent_hugepage/.   This requires mounting
> > /sys and is expensive.   Is it possible to put such info in vDSO?
>
> Alexey Dobriyan proposed adding AT_PAGE_SHIFT_LIST to the auxiliary

Does it cover

[hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_si=
ze
2097152
[hjl@gnu-tgl-3 linux]$

> vector a while back, but I don't know the status of that.
>

How can we get

[hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/enabled
always [madvise] never
[hjl@gnu-tgl-3 linux]$

--=20
H.J.

