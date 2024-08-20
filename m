Return-Path: <linux-api+bounces-2208-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BA9587BE
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9811C21C7D
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67B18FDC5;
	Tue, 20 Aug 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKraAy8B"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B418E75F;
	Tue, 20 Aug 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159964; cv=none; b=l84K0IbjIQaB87IN2G/l7anoUCQCBlRj5j4ulBAiAHptbtNSuX0BmMqFZyjI2V7KpephHsxGZcMZdia8K/A2qDUhNWqZEVrtEuksQJVeOyjENu/8C3hDZjQDmEyF4lc3mK7SlN6Xqa7BQ6ZVeKSRw/PYrZHJm0NuYlcB0mF3IJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159964; c=relaxed/simple;
	bh=0TjgbCHN1MnLYCG8DdbDuCE4zOOSeudu1n3OyJHONjo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=CV+vUMmCqvIRFW0bAWLHjwekpAhQWhbgzDM/VXdHR57Vzyy8nFdRFR6JslWOlxyRaoJm7a3v2Hr1WZ1Gf9/MLXiiYmAgH6w98QpkAA3ssNyfFEvJ9/Mh8tmU+Se+lwobc4t1LbgkT1ZzJikvuHAp53R5W8HUkQgsMqiVPvK2l7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKraAy8B; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3d4862712so840164a91.2;
        Tue, 20 Aug 2024 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724159962; x=1724764762; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TjgbCHN1MnLYCG8DdbDuCE4zOOSeudu1n3OyJHONjo=;
        b=gKraAy8BDWxv2mXW9iwYZl7agYNcHEPMaHXGIm3KePD69Ow7Jy82hv4QU0lMRmtlWT
         utdqcZqWu29aUk5On87+kaYL5X+gXFomCVKLx7C8s6w2bPtaYPVGCkzWrqmsy6kkPsIH
         MOESQgH6KHQhAUMcDy0xysbvwDHx2aKYod+/iolo3+AL84tRP+fYDVrrKWJZ2Yn86da0
         GIeUBkxVJhVTKT7IqSTYRrHL0qWqM+ltbNyGkmFEvjzEQaOp3bhyXK+Cm2RL7R2ZdH6K
         DEv61qxmSGwp+et/K6DPiF7Jn/NZJH8pzm/pN+ZOQX4SH1tP0QPnrgpacZh0peaoa8+k
         K4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724159962; x=1724764762;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TjgbCHN1MnLYCG8DdbDuCE4zOOSeudu1n3OyJHONjo=;
        b=Acc8Q4gL1Tom+XiHyzOH3D4njoNINvc/O0hTctybjxqAoGEoh1d5Brdo7TAjkiZSOe
         RbmfgH01Bp7WOo3M2nY7VPQb+DzR+dgCHoywYFBbkUmwYMIbObYuVvneRjfC+FCyvzlQ
         tWTOk2H95uLEq2/BALGYuABaxykVFF3lN3I0/1dfcJikdwWJ+Yqo59qqXeVeVijD0M2D
         3l0++H3BkIBeeHoaZZe7LIdL7svi0fvy8wgJzXziyL9r5oJK9xepDNOihReAlJHIyRs0
         PjYHp2Qkupd/ZIpLRrNSXJC1TL54NfG76bGg4c00wSPc4oKc0Vyu9DMlGKvQIn591s7P
         2MWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+1h4U0bwsWjNJ9aypmaAMwDPr+NC0S4Ne7I4yGDk1z8aekpG0GhAvo1re4B2KCps66XIC8nyd@vger.kernel.org, AJvYcCXJF1O1+I7CMxKno3AWu8NQRsudaD8dbKi7HXtUPl23PKai6nnjzeUyq6cew6J5SO4rUPElA35ah5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YygznAm+93LzaK3G375R5qlZTnT85yOj6rARY92qYiAOFLcFY0N
	PP4c2q6F2gXlERJSdeL7Qb9k1RyKkK7t66NrbA+mk3+CxSRH93Xp
X-Google-Smtp-Source: AGHT+IHIu8WdPeUDBAB3WDWBCManYJEhF6WJB1Icw1qZywYi86/Wscy1r3topHHOjPPeRuCqm3bITA==
X-Received: by 2002:a17:90b:146:b0:2c8:4623:66cd with SMTP id 98e67ed59e1d1-2d3e1a42e70mr9290342a91.1.1724159961737;
        Tue, 20 Aug 2024 06:19:21 -0700 (PDT)
Received: from smtpclient.apple (va133-130-115-230-f.a04e.g.tyo1.static.cnode.io. [2400:8500:1301:747:a133:130:115:230f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b3ccsm9414706a91.20.2024.08.20.06.19.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 06:19:21 -0700 (PDT)
From: Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: It is correct to introduce new sys calls to stable versions?
Message-Id: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
Date: Tue, 20 Aug 2024 21:19:04 +0800
Cc: Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org,
 WANG Xuerui <kernel@xen0n.name>,
 linux-api@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3776.700.51)

Hi, Greg

I saw you have included commit 7697a0fe0154 ("LoongArch: Define
__ARCH_WANT_NEW_STAT in unistd.h") in your stable trees, which
actually introduced new sys calls newfstatat and fstat to Loongarch.

I wonder if it is correct to add new syscalls, which actually changes
the kernel features, in stable releases, as it might confuse downstream
developers because they may assume the existence of a certain feature
after a certain version.

Cheers,

Miao Wang

