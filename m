Return-Path: <linux-api+bounces-2098-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB1945BB4
	for <lists+linux-api@lfdr.de>; Fri,  2 Aug 2024 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51BA1C20C07
	for <lists+linux-api@lfdr.de>; Fri,  2 Aug 2024 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE69214B940;
	Fri,  2 Aug 2024 10:01:55 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4D3FE4A;
	Fri,  2 Aug 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592915; cv=none; b=B/7wFc21AI2UdThmqLmT2jAFEe8dPbnC5ZWs1AvPgqhlTAzcYpHpepucNuhfKDgVM49iL2AfNkDGLG/5stVCXcD9/+1Q+blWjguQNXiVgRGS0F/NPlZJidxDa29LbG7oq7ohCOUR9Jidok43Wv75sbJlprvV0xM7UQGN1GUyirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592915; c=relaxed/simple;
	bh=oFu+TnUoeu3/xVNfNc7+7+HB3IyixnKsJX12ZHYO0ME=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=R6RO0HXjalEokLlsjVXa/ms0uFOIdg7fOGis+F2qyd+mcYshhZ08fOlOLkRwVgpDeZevLhCpTAIxg9F3dERB8l+KYvAPwSUhgutZIvEKHUGM5V4dcVXeuPu9GkDvWg9LPAPRsi8DVViu49u7t//exVT6q4JLs5EkwBb13ZxOt60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-XMAILINFO: MhRA+Wg7eZqsx6gtdB6m84pmWxA4/K5x5g9IQows5qsYekF+6hNhnM0R2sr8MjCe40Jh9cOcRrPK67SbLFjBEtELZ3PxzD6lMmWohkG1xYGaHTSYC1e/v8bsVUeYgWW8LjGZmRY5t4Tl40WbhJCKMW7lEqi7CeTaqvJFDAWSSnPzmvvW86ajV+a1N3UAeN9ifTjPkuROODd4hHPAHvhKieYQYtTqdJvPP6hvxE9Eq+/XlIGUU0NeFjCR6jkhPpRfL/PU/2BVBMAXUYM1MfXhicqGy4YiewyWBqs9aje06XnNMMmpQlx2a3qD9gm9uIDaCR96++cAOMHrbu1RsHiD7tjbWFppheoo165Jn90PNNHcpEIZqFLynWlG8B8a9Ja1F5F+YEVnPhRflmxP2pASPqv5SbBNJBEP8Kwggd4x6srD9dc/67vur0yt7lfb5JzNHT4jHAq52CLHNuzY02NeJvZOxelKsE8/gQ5ZTHQIcDuWzR9H+NpZCoN2bVemgt4no/nLapBdJqklUU/blPtCPcrHsu2tzkFZ46i/5o6LLl4D1fLmtZpw/heoAj7j9Ueaqlft43V4v4vEQD1n3WMJlvYL/kkELZv9iZYsaDVKMNkbpLDhjRIL+iUU7GrSK/8EenCVqaGgXYbTRtaSIn8MQT7WgkrSk69u0qbJ1KqDSL92fd/gwqRNM6LkiiBPQM6oWb4bRWu7VxYgwaTS1nwqREOyiQZZ3Wr8ktL+bKgTT+NJo7VufE+QJK4ngkTrec+kld2P6OWguMnweMNAmGVaqMyJhWlfQ0C6eOB7xgtQsWsyBLCb1VEUPlgB6bo6LNhHWedUkNwKMZAQD885cyD1hhNEG2DpYrWoFKDH782wsnl6seeU49m8NcMOkCLgS/M5pA==
X-QQ-FEAT: 3C1WcPM5lQ6i2sLB7YWRle+sn1bwZ2c0
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: m+IRd/GzSDArf53hlT83q+hc267PoEdDavp8CFdsudY=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722592886t6188300
From: "=?utf-8?B?5r2Y5bCR?=" <i@andypan.me>
To: "=?utf-8?B?QWxlamFuZHJvIENvbG9tYXI=?=" <alx@kernel.org>
Cc: "=?utf-8?B?bGludXgtbWFu?=" <linux-man@vger.kernel.org>, "=?utf-8?B?bGludXgtYXBp?=" <linux-api@vger.kernel.org>, "=?utf-8?B?TWljaGFlbCBLZXJyaXNr?=" <mtk.manpages@gmail.com>, "=?utf-8?B?cGFuamYyMDAw?=" <panjf2000@gmail.com>
Subject: Re: [PATCH v5] epoll.7: clarify the event distribution under edge-triggered mode
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 2 Aug 2024 18:01:26 +0800
X-Priority: 3
Message-ID: <tencent_19A1E2025D8C28856380EE3E@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
	<4zemhoksplppb35pvpm7cahmaar45hhn3s7tne5pqbgx5bmtg5@jj6hz5yetm4z>
In-Reply-To: <4zemhoksplppb35pvpm7cahmaar45hhn3s7tne5pqbgx5bmtg5@jj6hz5yetm4z>
X-QQ-ReplyHash: 4294063989
X-BIZMAIL-ID: 13297403771574948180
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 02 Aug 2024 18:01:27 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

VGhhbmsgeW91IHNvIG11Y2gsIEFsZWphbmRyby4NCg0KSGF2ZSBhIGdvb2Qgb25lIQ0KLS0t
LS0tLS0tLS0NCkJlc3QgcmVnYXJkcywNCkFuZHkgUGFu


