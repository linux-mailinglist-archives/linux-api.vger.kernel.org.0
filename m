Return-Path: <linux-api+bounces-5816-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jaKqFTw8iWmu4wQAu9opvQ
	(envelope-from <linux-api+bounces-5816-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 09 Feb 2026 02:45:32 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03D10AE66
	for <lists+linux-api@lfdr.de>; Mon, 09 Feb 2026 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E96193001A41
	for <lists+linux-api@lfdr.de>; Mon,  9 Feb 2026 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD418DB0D;
	Mon,  9 Feb 2026 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd9rEslU"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3842A80
	for <linux-api@vger.kernel.org>; Mon,  9 Feb 2026 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770601527; cv=pass; b=uKB/bQ/ca06wLVPL7JNWut2CLueu8ntGcqy15Dgchun1L23Jo0PbekcgREgvw5NMvJGeYY+GNfCgKXRnaVu4CNh9aLc1d0d9XpxABGteYojsygEXxb12mlJlJI8OeczWW8DiupDCGduhXXIYo5iwVJQ8JEpElXcfeWSrAtYCsRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770601527; c=relaxed/simple;
	bh=MS5zmnFRe+061TRkfzkniEZhajw9BVKNtmxCHscKhUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSrDfUNaadPlzl3B2dnH2vSNL9P0soJhfuSFKCRWnqqTe2ikwsQcjm1a0DfDaxiAtCmUUqAWqVYXmsIykFXG2EUTZYs2iBcIy38wTn79kmTfbyeqvo2zKScpR9GIpsMHg5QbGhl6KroTPWiZk5/CCyrt9JXT8nU4485Y7+SKfTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd9rEslU; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-895341058b1so36565786d6.3
        for <linux-api@vger.kernel.org>; Sun, 08 Feb 2026 17:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770601526; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0vZPFaIOuhwYvIhlNBRky+UFvLp/yMUDm2Jo5Rgsmxn4+Igo1cltof/+wo2T151h/
         Q5q/ncJkM4IIZzqX3/QkNoS94IJ+DMus8Ok6qB+W3075JtuWP3XvwvguH+Xg74vIjup9
         /1/l9qkNTuFUygIK3a5JvkGwh5OHH/Xe1A6Qp970gf9N6PLtuRVzZ/H+8tWNohrw8Mpj
         QCOpsp+vLLMmA/r9Ck8N2rWqp6YUmrdCUXf8I0RyV3mznNwSlznjILhVUPaBwpeB9a+m
         b4a0x4Kt4XekvGhrW/A0kwmc+u8S02gnE7h2JkvRV1pKpenijBr/gbeV220d0mirBKYa
         veFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MS5zmnFRe+061TRkfzkniEZhajw9BVKNtmxCHscKhUI=;
        fh=0ye2eq/dtZ1Qp6jLeAXS4jV2eZK0neq08x6C9uAL0YE=;
        b=W5CQ2DFZIFlGeflUOjzSQ9Q75Ydq2OaQ0VYYAQBs2mHkcK2HO0ScXVsaB3ykUh5iT7
         sfcmcYXGLJi9CMWGEx/MiPnBItlZ2K+zqHjKIW8eLNZNUkPkA6/dQqinqmTx6I2dXsdE
         wPbl9tPt1rPWt62i26Uw07XoARhrVXgOgpHzGwjEHA8L8e1lkJhqjq6tEQ8cq7of9ma3
         rY2IB0a/U5U6O8eLgAVz0SXxw+6D6RDQJnj455QCkP/LS3VZDEZ0wipBkznXfrqoexdT
         E07P6x25uok0VfoyU1XyvRt41ElvDiuI79EykdIXFTnvvjqc+/JntVNtRQUBaZP/ivT7
         JTCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770601526; x=1771206326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS5zmnFRe+061TRkfzkniEZhajw9BVKNtmxCHscKhUI=;
        b=jd9rEslUynmfMc1DajTf+AgCAyBGNcEvCm+DijBeqJR6EqIzNxZBiz9Yfk6Gd7QD47
         +IEQTGQZILJb2OZ+FVkyQChMAN6EzXc0n+8FfUO+5im0Mwx6Gw2amFGwGCn8VlFvQdvf
         szWcR9ALYI/lf7hlQr73/llwH3NNrv/M671L/PFlg6dHNZs6XzUpQsY2eerwGAs2zp+h
         Pk4jvPgjad/jkmCuknDCoBTZ3qAH4Wub29fTSS3ynquiagMuGpkqSn6b4jHppa5TiXrK
         C4586OQiFf/pSOLsWO5zAC3yijgWK5GkyWs9jrwCwWMmhA9vU7TB/jInmggXjsEfFvJv
         1CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770601526; x=1771206326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MS5zmnFRe+061TRkfzkniEZhajw9BVKNtmxCHscKhUI=;
        b=jU6Vb434SVa9Elg62DYRzkceDAi+0NDaV6JCLaHTuOsNfn3RNQCQZcyJFXksp6U8lj
         Rn4dHv/IteIXhqoM4UbXwWMxIC7rT1uh0JAgW1vigbGGdVcMZK/iyxvuClrL0Sag5/O4
         WXGZNhbHQ/hhHWJeHgGEGNlg2W3fOH91F3oxiXwpRD4vr7qL8qUi/h4KUHAzkZxmnPnn
         BUlPpZxcaL7QFgXm4IyFtjdIN38t3gM/eCNncnpENdxYuSo+fZkLZNllcnsTyRQ2K3Dv
         WsgXH45tE/75C5rmx5iDNuVXJeoQOZZidLTjkEM52cs6gl2oD8fpgPHen0w2O1yVoWJ3
         w/Ng==
X-Gm-Message-State: AOJu0YwIp/kZyY5M0BEOoVJV05pVtVI/rTwk6f9xLNspFPfEMg4G6JK2
	qxTPdfQBXFUTkpF2C5tJ4I9GnShhcR+itgfGBtWnKLVRpIu581Y0t5mbrVycoSJrjiZobPuETFj
	qlWjyEc8gJ9l3YXKF493rPi4FyDS/qZ0=
X-Gm-Gg: AZuq6aJgpjxD14vnnI8gQAWBTpYYxgb6g3/zCU+RTv8lELEEE8DujKnYpBeGAF9xrHQ
	EcK+KmPf4WnxPkNGr5v2CtwaCCKf6GVMe/loytLcijHAsJ8IbdWWVYz+XXpH1nfNo9y5euMM+o+
	Qt4pCj+iyJrXI/6m3IJuuFFhi/OOo7+tb79TuJyZbtI1NeM8bgKSLhoNwvqN5W+lpQRqKhPBJj1
	SB3nSqeXI9I9DAVFbjOKa+QVcUHb4X3GqWglbISgQG5OX7/ok61Q4Li0sISo4hJCNebkFlZmv4P
	COOhSum7sGAOWt4p38dKJJKBc8ziyy02wUA0JcQHacCOfKcp5afFMo3mz+96HSAW2lC3
X-Received: by 2002:a05:6214:d46:b0:88a:2707:58e1 with SMTP id
 6a1803df08f44-8953c7e49a3mr145879386d6.20.1770601526345; Sun, 08 Feb 2026
 17:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209013041.37536-1-enelsonmoore@gmail.com> <017a28fe-6c0e-48ec-8b1b-10e0d3b0a04e@infradead.org>
In-Reply-To: <017a28fe-6c0e-48ec-8b1b-10e0d3b0a04e@infradead.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 8 Feb 2026 17:45:15 -0800
X-Gm-Features: AZwV_QjcUPyrEBqSJ5p-7XFq-EUqJYyOszX2WADnCTdXFOE-v-jyClIPieD5e2E
Message-ID: <CADkSEUhoj2Hfix3SsW4LJqYxrN294CT449MLVtjpE9t2okAk+A@mail.gmail.com>
Subject: Re: [PATCH] arch: m68k: remove incomplete, unusable Apollo hardware support
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-api@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5816-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A03D10AE66
X-Rspamd-Action: no action

Hi, Randy,

On Sun, Feb 8, 2026 at 5:40=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
> There is an M68K maintainer who should be Cc-ed on this patch.
> (now done)

I already did this in my first email - this email does not have anyone
CC'd because it is just sent to linux-api because I forgot to do so
initially.
The original email with linux-m68k and maintainers included is here:
https://lore.kernel.org/all/20260209005212.32370-1-enelsonmoore@gmail.com/

Ethan

