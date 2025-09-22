Return-Path: <linux-api+bounces-4906-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9013B8EA66
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 03:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE641899184
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD813774D;
	Mon, 22 Sep 2025 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu7tvw2M"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDA12CD8B
	for <linux-api@vger.kernel.org>; Mon, 22 Sep 2025 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503218; cv=none; b=j9eU+84O3XbuaLCBc2iZm1MYNsLPBW+yjWXg3mtILa5P7VqIb0PnrViTwex1KZHWOtJcb/vrnGOTyHb1R2HH/P9hHhGW/XytUsoUPMdmNkeySRanWYTrM6JVkDWdxC6C1y63swyyGxCGWlEI13XT7Ry9/0PCA+TQPSWywM41/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503218; c=relaxed/simple;
	bh=asv8V9+Gueu0sNN+f4Gl1Qt3MQgb39wz7+eIfVPVXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAHXk+xcET7wiNxBaX40UNZpeQHc1uTwWU5NwNcC/bOSDR0Jg7gBfXCmEgMpJMZgVWbWlvJnmBLQ9XRp60jSmBywGq3J0jrqw1Vx2FKjeYvpmhXvpsF8XiIqZXV52mRnhj3tPVPqMzUJQgaeIQHodXfmgOZhgDC+mkLCwib5vAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu7tvw2M; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so2349459a12.3
        for <linux-api@vger.kernel.org>; Sun, 21 Sep 2025 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758503215; x=1759108015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRFzPXWkpeV/mjt0GnDfb09q9PXvnidCDKuEHBnZ7Yg=;
        b=Qu7tvw2MYaQL0yImQzNFv+BBEyaSNuF2pxV9fNky6RwH2DzTPNV5KcHGZ16sLApyrn
         agJukdp0o0We3p5OyBDueUIrnDoMk0w9qqC3CVi1wiVbgZ0jhDyYS1xasv6YyGV/X435
         ampdDzP96gOwodws6vcJq5XbN20F4N8TFwIbMYAIoenv8egSyAdV9Z7XugJGoBVLPP6x
         vX0sWgMA+v9lGWezkCzqO1MM2w27+1pNJKJF6WeQBmMBkC5pKrusxeEnHnYRXFkpvCG/
         ARcMFtExxR27sDASnmWXmJ03zYnoUpk8rOmdSg03uEu37hXsbYXYau2mnBS2KgU8Mkt2
         yyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503215; x=1759108015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRFzPXWkpeV/mjt0GnDfb09q9PXvnidCDKuEHBnZ7Yg=;
        b=LvFI0X3ZJzZ8Euo1OHlGOkTZZqDLoWUWeP57YioBVuP3wD5dCxehtoSQFCHx0bp28v
         HzsNhFXgR99sXz578Iw4k2F+mPjE8OSiXpOau6cfKyqGGtdmP3auFveA/GkQlrcwbzEy
         bLRnDwJWn7Qo//ul9bKB8s3lv4WWdsQ1IpNc45gOcqKN4dJGHEMBtbRiMEqXIN8Nsbla
         zjTObP1d3OyOlCeACwTdyVS0f9kas2An3eXfOrvINO+adONxFU/igLZZg/f9fk6lLwt1
         Ga2i4+rp2zBjf27aKBUaLWSLiS+MGdjqi2r/TgdYv/kxDxQOpb0MtOz+jIJAJibUDLjp
         0EUA==
X-Forwarded-Encrypted: i=1; AJvYcCV30CwinLcJh+hswLqWua/P2UxhAYaq9C5SJ7z5n+19ke7+yus7WoOlLDJOyT/uQedkVrWxfNeSXsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67h+wGodngEZ4SR47NbO/x5AWlRVcU/j/MVdnM+8wbbEWRBXx
	2ti+Eqt3ErWcuFDigjoUpH2/N1lK1VDUtSg04j8kTUC6pHqyeEe5KNud
X-Gm-Gg: ASbGnctjZS71GJYn++LP3mTUwYOK1teWIIcq6Pr27BTpSnMIKkIhhUTGYfRZLZDD0MP
	kWYDmpt+teZH41Kym2nYKcCAswa2Nlov2w8Vg/j1FJLatrDb4MoKTJVDhSfCGFr5rzSAP+BDKxy
	QXGne3JYsR8HWYfhLp9+3FaQvqAqwe0wxBV9xT9BzFKB2gGVsBS+LeHZS4YDil85vK6uq4CCZBJ
	rPxnRbj2Cpkb+LEQcMFY8dk0ndqBk4pp5NjuPiMa1AD7tHJRcfhaRYcorjEOyAtNjX3X1MdekZB
	cv0FWUW7yuzhJquU5sFQY6hTIlVdnGzhyLxKlJGNro4WQvCOKFN2cBfW2nmEPribZfo22LmncI4
	e3nLEpTy/BN5F3eODJh0=
X-Google-Smtp-Source: AGHT+IEE+dlkZ61hvZbcIoJcLnr6qbKVmAfG180HpIGplBEyYngiA6LG2BlkeTTj4jLmF3uK23VJkg==
X-Received: by 2002:a17:907:3e17:b0:afe:74a3:f78b with SMTP id a640c23a62f3a-b24f6120e79mr1092368266b.59.1758503214799;
        Sun, 21 Sep 2025 18:06:54 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b264fc793f4sm640643066b.17.2025.09.21.18.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 18:06:54 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 10/10] man/man2/{fsconfig,mount_setattr}.2: add note about attribute-parameter distinction
Date: Mon, 22 Sep 2025 04:06:49 +0300
Message-ID: <20250922010649.96399-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Some mount attributes (traditionally associated with mount(8)-style options) have a sibling mount attribute with superficially similar user-facing behaviour

"Some mount attributes... have a sibling mount attribute"

Something is wrong here.

-- 
Askar Safin

