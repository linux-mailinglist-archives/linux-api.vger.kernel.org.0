Return-Path: <linux-api+bounces-3173-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBFBA2D91F
	for <lists+linux-api@lfdr.de>; Sat,  8 Feb 2025 23:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D297B1887197
	for <lists+linux-api@lfdr.de>; Sat,  8 Feb 2025 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015917ADE8;
	Sat,  8 Feb 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="n/I6VOh/"
X-Original-To: linux-api@vger.kernel.org
Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DD244EA8
	for <linux-api@vger.kernel.org>; Sat,  8 Feb 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739052110; cv=none; b=OpQOePgbo4tcH2tnMMJrFxTn8pzK79/xGWsK1k7l3GykyVGrIG3/R6iHYU8XOlRyHPbqI+YannOMoscpBqKX+BdKxYqGM1iGcKs4DUyhGLuAFrDjc4nQw3luH73LJygFRhduVaE1tUnd/v65WUbOWSWpmuQNQOv0waGxGYfPkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739052110; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LoTnzHbMgFAcbvXuIw1HEtHCqBeRF34y0AQSrYNdrR8U3GTAaifNL6CML6MCbQ6ZTssvUprWLY+JsOSJHh1SRAkwcA4k4qPB/rVrHeUVL1N/xZYCIGBYfW97wmDh/1AIIznFv5HAIqxdFD5uNOaYTxrBoOXLSIjoC2YczWDFcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=n/I6VOh/; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=n/I6VOh/9vFc1zEy22ljRA4GJo
	pHuu3/Xuvnj3J25XzrAJ1Omah6g8WetV2UEVpCGZQ1opQMJA3WRjPDr7t1diyP7zU7ZhGANfPCGw2
	KCA/wlRmEGAl5AY7M04v3/C0iud9lcYQvnry84gmj5/8ZaWI233B2/CKWgT+rPPQHPHVepFgEZ5WC
	igbdELQko8LlQFJn1bbV1sVLd1IgEb/08CBS2fZEwSHn07LBMCn/O3LmLSMPczSd1dS20PWUk5I5s
	dm5gUXqSJl5LmJo62OvEDAit3xDvSem2YD4zl+MKy/X6UrmPwdzU/AiHW73T0E+TKA/nE8hl15cTq
	j9Lw4SfQ==;
Received: from [74.208.124.33] (port=59418 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1tgstU-0007jJ-1y
	for linux-api@vger.kernel.org;
	Sat, 08 Feb 2025 16:01:45 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-api@vger.kernel.org
Subject: Re: The business loan- 
Date: 08 Feb 2025 22:01:47 +0000
Message-ID: <20250208210542.7C504FF499F35DB7@truemaisha.co.tz>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server-598995.kolorio.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - truemaisha.co.tz
X-Get-Message-Sender-Via: server-598995.kolorio.com: authenticated_id: chrispinerick@truemaisha.co.tz
X-Authenticated-Sender: server-598995.kolorio.com: chrispinerick@truemaisha.co.tz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

My name is David Song, at AA4 FS, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
David Song
Senior Broker

AA4 Financial Services
13 Wonersh Way, Cheam,
Sutton, Surrey, SM2 7LX
Email: dsong@aa4financialservice.com


