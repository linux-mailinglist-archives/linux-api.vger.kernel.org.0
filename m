Return-Path: <linux-api+bounces-4907-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45FB8EA76
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 03:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B54B3B0A2D
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 01:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EFC145A05;
	Mon, 22 Sep 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8ZoIfv9"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF61465B4
	for <linux-api@vger.kernel.org>; Mon, 22 Sep 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503444; cv=none; b=Y/pon+mqsG45vXVBUsR76rqWhSH33IA2H6Zka27P4AyaIfBGjQsOeZpF4gV74F4VC0Pnqa45khTD+1JsB8Jo5DEWKrrlR8EjD/ZPtY66QyHRXPK+uodvlpfu9WbSkpt/1DRlT+NCt+7xy1eeiHId0OGhe8FtYbpQ4vWCfnAk8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503444; c=relaxed/simple;
	bh=M5wz9xqOwUfHtDVvMp9nzAi5BBDdS8BQxS9fvLMQ0nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgdCfI9JNbpzhovVfV0PE9qEEOkrfE3tuVyrWfAv61Pv4SQ6vBpwT9ADIAYwSb8yIcew2ZVMMxg885MUDCuVsgGzN/Yy3BeTaQ+Fw7XESFctWrNGT3cIedvWeHWf4tEgw5Jxp4VeWuI+u5RQrgoGOg6tTD6UEv4448C2h9V2Z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8ZoIfv9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so111290866b.0
        for <linux-api@vger.kernel.org>; Sun, 21 Sep 2025 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758503441; x=1759108241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MkJ7oUnUH/4XWT8grjBfyBKEOMi6atBFTqk4gqmuuc=;
        b=H8ZoIfv9DSR1/hp6JpXytlIGxWeyxbDOAgZ1ldhM7onVV0tw9ZOLtFyVaywrJxmn+j
         DDSO0l47Z9Qeoi8mnW2W8tJS0CDzx/NvkJVhlimIf6QKIIJ+++gy6ddVxb/s9NO0pzpQ
         ohzmZRk3iuXgw3lFYA7H+h1WxCaY5OLsfoBZL70HL44Q89ZHURlpvTdsndiUplxTVCho
         fAZyp7KXHYeyXPjrdAF1vn66OXoDvfbpVzF8dfzqdB2GHL+PlESDX9nsyW3SCBpSNIgT
         mc6XdOXDZ9DtNg9H3iTRCIgrA3VDrI7X1OGGvN8K5Dh5Y5kKrB47Wt3Bw++oZqh2fGcQ
         tCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503441; x=1759108241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MkJ7oUnUH/4XWT8grjBfyBKEOMi6atBFTqk4gqmuuc=;
        b=WiGETVPcMstXqZ8D+18KKzzGOxv22BMjM/HBdXHQ9Zw8ZPzTTHEKR2bwZBW4sZRy4v
         VjzRbMK3SELwD5qhmG5/XddsAu+EZzUTFIE7f93qHpj91m2ftEQJ0CE4LZK0zcq+QBqa
         ezKPaWVPnZTT13+WpivKoj7exJRCtOxcxd80UlVTawg5c8yPbfaA0E1Azu5TVHtN5RsK
         5SxUPZIThGANQc6VY7W7wttg6VTrA5g7ozFQFR9O65YrycXLeODm92ZxPSSzemkZNdfK
         ZN5CRpGulFJoCDSvexwNsa2xTwnjSNCZywOP27cU/DmerkWX31ZZJLwddbjYCMj5/JS2
         8hfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZkS7m8mig5fPrpWAwLbBU4w5s/3BmpvUC9MoFmbAM5DF1HuCfoyAxuxzwWknbAb/0tn5Y0uYbpCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgojjqtK7dkZcxfgsju8KBWR2zK/HPyJ42N6wILyVy6koHkBDr
	52ILoM7Du2MRzhlE4Iqi5om4FFqoOrbH63aQMPjCRXf+XUufHJkf8Ika
X-Gm-Gg: ASbGncvuLFLdNAkutHxvzvhzdAfVn2WNEtgj6kuEroIczU8EDC3AVabg74UYlCfQjF6
	WA2LmlxvIlppjrVCFYEckYMdVNlgKi7GtMj6X8ZIWA2TAslnicPU3Jqs2554GlPmpTaxRLww+PT
	QpQatXw3VkZf47bhatZb+3RzxwRRw8n2dXrF14nTYG9i8vqV4zQPFVtKtbjix53UBJSXO6ESFoz
	Fw/0CH4jOlAjrg36nXBdpWM+QZWyKnyy0gBhxr7u3OQ4ucya6is/RjfDnH/fEbRgeMced45336p
	5l+NNkwKXtNM5yaC2mrqHoq+NYA1oK8m1CH3lXCb16cRoe/kHKTzCdikzpgs4yjLeXQKw67lwzU
	cFLg1sQ7NPa/Voi5xhBo=
X-Google-Smtp-Source: AGHT+IEvTen8ntQeNOQqNFT2eKUrH0+zq+HnLQQTKn/Su0UVk9XUetSFBmS6KjUaD9cJm9/WF53iGg==
X-Received: by 2002:a17:907:d0d:b0:b04:6546:345a with SMTP id a640c23a62f3a-b24f442d830mr1120956366b.52.1758503441503;
        Sun, 21 Sep 2025 18:10:41 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88bc3sm956702866b.51.2025.09.21.18.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 18:10:41 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	cyphar@cyphar.com,
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
Subject: Re: [PATCH v4 05/10] man/man2/fsmount.2: document "new" mount API
Date: Mon, 22 Sep 2025 04:10:34 +0300
Message-ID: <20250922011034.96618-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250921230824.92612-1-safinaskar@gmail.com>
References: <20250921230824.92612-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> MNT_DETACH, not MOUNT_DETACH

Same for open_tree and open_tree_attr

-- 
Askar Safin

