Return-Path: <linux-api+bounces-4980-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B6ABAEE61
	for <lists+linux-api@lfdr.de>; Wed, 01 Oct 2025 02:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C4416B237
	for <lists+linux-api@lfdr.de>; Wed,  1 Oct 2025 00:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB21E1DE9;
	Wed,  1 Oct 2025 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTT9/K0O"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD81DD9AC
	for <linux-api@vger.kernel.org>; Wed,  1 Oct 2025 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279134; cv=none; b=p+ykHR0PfGuG7x7E0y9rtJ+QvMgrLfA8/E99uYaKeaeh0Jk2KZFGmQKqGVmVdUXC43Bl0+g4LrcDwysCyO9Cq4naaaM3IY5pW9XvcyMkgzXXTw26S81NY7/qlQsWseQuytp2bqgaof3V0xNviDY5eCH8givBEWKFc6P1Rkm9u0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279134; c=relaxed/simple;
	bh=pTt+ujkaZVjzP+3E74ZC6wkNRrnymwupPOqQi4vVrqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0Jf6FlkRJThu3Z8HB2Jj3wD9x+tp6Po4Yk/c1LRBqUCHkshu8gaPN8tg5Acwfljlq5I//dpKyJCpOs66NqFPJT0VTkME4xt1wv0AXAH1yn7sALfRHypHpv1eJOl0CH645GhjRteI/GcBShsMWz7D51u4bFCViLljkOQ1+WU3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTT9/K0O; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b457d93c155so232265566b.1
        for <linux-api@vger.kernel.org>; Tue, 30 Sep 2025 17:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759279130; x=1759883930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80RkSLcN1Mqe0fHp8+5X2rCf+ePo64S5nx0U5sFjDh4=;
        b=VTT9/K0O0oDwmgwwY5vi6S7WOAik3VQgHyiT/6SxbK9ZUHaQ5GSAQI1JI/zqRxoJvk
         Kpyry0MQK1AOkFagG9dCMZLm5/jCxooEDL98twvPRdWhfuU/aXm2Dj5YTX13PN+Z2K7R
         aMEaLi83fby6RYzPt6HA05Qd+CVGNAXXrj8OB1VvkUd4JfcbQRPyeycTWQgHJYt2AX9g
         1hedhTKYBu/9+doVgrWQbvqIgaBTGRyq7ZU6gc2/Wd+6XoaTvp2WOVs6uG+vGNewgpuf
         HDNYBAkj4AJIOLVZax9WwsowRmQn4BcoADFixmMr327lncWOMgkKMxI/yJgbqz3pIWMI
         MC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759279130; x=1759883930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80RkSLcN1Mqe0fHp8+5X2rCf+ePo64S5nx0U5sFjDh4=;
        b=NrqaGvuuMnIU9ge6rdkH4oOcDsL21ttQZIrUyxdTJDQtYnARDk/v3KIXYX45K1F8GR
         J+FT4bHTX2mGf/OS46aFQPLxAffVTJNal2GJuAHsk/bLy3iCcFDJ7aCk7Tj9Fg5etGo1
         krV4TZumXE4VWEZMTTR0pOAlj9sJeqiNkxCP1oeQtduxtaHN4qDcLhK7e+pj3pmP4C+z
         BpXwkaZRoij3jszoNFwfHIcFE4wPnZAbY90i1A9DNO7UFaw2xLsKe/WNJK1Y7Z3/DevG
         Vbo2S7jk3ZfFIyg5dHX/YKSeQeTnDnyFrssE/gASHfHqlz2iyU7uSe9pZfA9hB8amKOG
         rg7A==
X-Forwarded-Encrypted: i=1; AJvYcCUS8lP222QzEVOzpUn2rSih7vCwJEdpEACsQoQRFbjYvZtg761IcfIQm4mAdW3A2gXeUQrW38UuR+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9fx1NTl4rBMGA6hI4k4Leybn6S+PKU5wW9VapNm37+OZxs7g
	EXzf3b+Ewehktd8x6ljEKS8lr9h3On7nJd7qZiivVDsrgR5b0gmza106
X-Gm-Gg: ASbGnctWwc8eCWriwB2Idu6NzZ6ws0rYlshBGaFMJhjPBetzv9cGt22ahnxi/YG+YIg
	Pnudh6+ZZe9l5I5uNoc+hJZMWVzJkQDzoK/tYrtJx3GpbcrQrO/yy7MQMXgx7JfJ7QORt+m+Tv5
	0rVe7541bXMCufDsHilxWCrR46iIm4Fow/Kac2qJ8wsX5sPbe6eKUNb1z454Ovgo39wswFBC6Rx
	SkriEXIVadBW5YHj4bVKFQ40H5MTsZkjObGBIVKxIwNefm45rX2Uv1mn40VhyAbhdrce4GwSamh
	syoB6+NZDoqIdc6sNQ4Iz1prlBqF2un5HHGMPkWMDJbj9mWKshnQetcDJhfLgP1ThI7K6eQddvm
	Mdr5MfRdV2iUhBYlj+8CNonVZBuLSZGHd3+vFykVULjM=
X-Google-Smtp-Source: AGHT+IHK0/LlHSuoPWFmCm2v5eRSFa2VBRwHPtGKfZiRLiGohR1gYvmPq6f/J2GBYW0sSTfFl1HKAw==
X-Received: by 2002:a17:906:c156:b0:b28:f64f:2fdb with SMTP id a640c23a62f3a-b46e2626cccmr167161366b.4.1759279129687;
        Tue, 30 Sep 2025 17:38:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b35446f79besm1255821866b.69.2025.09.30.17.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 17:38:49 -0700 (PDT)
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
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new open_tree_attr() API
Date: Wed,  1 Oct 2025 03:38:41 +0300
Message-ID: <20251001003841.510494-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aleksa Sarai <cyphar@cyphar.com>:
> +mntfd2 = open_tree(mntfd1, "", OPEN_TREE_CLONE,
> +                   &attr, sizeof(attr));

Your whole so-called "open_tree_attr example" doesn't contain any open_tree_attr
calls. :)

I think you meant open_tree_attr here.

> +\&
> +/* Create a new copy with the id-mapping cleared */
> +memset(&attr, 0, sizeof(attr));
> +attr.attr_clr = MOUNT_ATTR_IDMAP;
> +mntfd3 = open_tree(mntfd1, "", OPEN_TREE_CLONE,
> +                   &attr, sizeof(attr));

And here.

Otherwise your whole patchset looks good. Add to whole patchset:
Reviewed-by: Askar Safin <safinaskar@gmail.com>

-- 
Askar Safin

