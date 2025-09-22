Return-Path: <linux-api+bounces-4905-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAABB8E9EE
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 02:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BCB189A625
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 00:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4373A1CD;
	Mon, 22 Sep 2025 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sex1tRY4"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822533997
	for <linux-api@vger.kernel.org>; Mon, 22 Sep 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758500750; cv=none; b=Nnvewr3e5Xri2zJstHSdyrl+icVWYMEfHnUP0aqiJXBcI7Lprb6gEO5iwsU8dAffIao3YU/xuwyHzmZOU3haYE5lJVro2AOWqVvXYC8e5iBnGtF/apB0YkVFi0dN/euZyyOkdxemlG7xB28Wp4y0jyPbrEtjKssIjfWZ3cg3H3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758500750; c=relaxed/simple;
	bh=ZYxkvytXWzIneq3yvORv4oZVMuSuCQF+rZ03OyIv+xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnIX5LWwQX3yt5OjYkj7AEr0k8wOoE1717A6I+BKfrxaGF3PaEHgUX2y5r5gm9bfYQ2nSvDVdSqHx8q7pJcy7kSDRAVrpwKwnGlU18HE9IJqucV4DNYQs2WaeB2+lNOuEkwA76UQCVuHZnYji4UalZ0jKED8+Y4mYbxwe9jIoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sex1tRY4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fc686dc41so2024312a12.1
        for <linux-api@vger.kernel.org>; Sun, 21 Sep 2025 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758500747; x=1759105547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qqow7NfKYjPX1vfqX6Q3EwqJhfVfsFixre7RiEXeVic=;
        b=Sex1tRY4smHZjwxR9y/gvzrQRCmWL2Wpx8XLjPy6G7vxxZVb9nJ2TJGuk94Rm0L5bX
         XHSQnft4THbXJSqg7cLjzuv1zAKjKdhvT6dCdHQWm7kr00JjDmQ52RkXFMXmP5fXdgdg
         f3/B7sdKpvJ09fR7gcfavrvsCyLyiTIl6jrgu5heWK1mwBjhJPOR8TuI9YiAEPQAIQJi
         qG8UkZeVOvVZ3he9RK/KZhwWhxc7INCnIPiEoV7u/LcYTPNXF27XC6T9brP5HjchDQ+j
         KpJ0neABxVhrhNQhq933ihNSBbxa6r82Rdt0zldOHKxlFswBQirmqmlzoJeocoXLt+no
         kSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758500747; x=1759105547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqow7NfKYjPX1vfqX6Q3EwqJhfVfsFixre7RiEXeVic=;
        b=cQE6DaunQbqQMfwIgy01K6qytkOh2bhm8ZItnio1o6zXK7pDZMAfGH+wAiTFwRki3A
         gNEiHAZHqBIciX8EFdfARnbnckbQ5oCUS+V1H+8GrNJbOSnDWKWL6wtaoFEzIXToL8Zr
         LKCBvry5sZfgly+Af+VRsdI32uHhrzcpQStaIZNvsWiSxf9F+7LCmyaxAKEv9DeNSv18
         6yrHtJBAFpQp5CwiGv8H5yGDJ+HMqKZauT/Mcar+gsMYjFOG3CDgesXmqb4lqluGM1Mk
         lN0PianOToub5nxheAbvQ2JbUmiimDhqAJagqowjf1GnT1UaCZSYDUxtwOPzdDYa9voC
         58Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVtuhJ9cnOzhrJwk/HUkmistceWlR/MdQWN4OAnmIn0UyMKSnBhoai/JQqTNz2idbr9qqs1NS2nlUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3P+V3ReICLuhWToKd7Lgq/d1OjgcJuSelnayWcAVZJpxFROA
	K3Ei7Dv8OWyu0xfOCeQzkesnPH5SUqSflj0UEEF1NjHa5ychCRKjTER8
X-Gm-Gg: ASbGncvSoIVMVHJip4JPam8Vk4SFjIEKcaYPu6obyPymFCZXXEQOowBs64mUapF2Ckw
	RUaBH1fChDKrGThEAoUyPdCHYH78HBZkd+Vv27wyN3dyeuMTMAdT3qN+z6p2tKHfrD+D8ETZYAO
	JhXtFn4DlgUeZr+RtKZCtPkJE99mMSCdlh1AFIyFb8DYF0vdOnVHdBRFJelHMynZ/leil0wJF9m
	TFgwcvmGvB7gxAt7Lgs2k/ejApmSOwjQYo2xy90crR+c9iHz14ExdYFKK/zyjTipzfQdnDPX/Gz
	L9Pj8nZSelRbRL3ZJXXO4+gAYb65t5JBqXqgagYn6wasDePXOkka3SDH1iIJEVfWh5x94AfeonO
	pSvJ9ayVXlLaa9dCVJ+c=
X-Google-Smtp-Source: AGHT+IHsbRcdXtV5go1CgGoP+4ok3H92iE4YLKzIeNlhHJMbPBRzYcrLPwri6hTQjbCbj0oX1PYScQ==
X-Received: by 2002:a17:907:3fa0:b0:b0e:a66f:478e with SMTP id a640c23a62f3a-b24ed97c8fbmr1084255566b.14.1758500746934;
        Sun, 21 Sep 2025 17:25:46 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b297f3f426csm374532266b.7.2025.09.21.17.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 17:25:46 -0700 (PDT)
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
Subject: Re: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
Date: Mon, 22 Sep 2025 03:25:29 +0300
Message-ID: <20250922002529.95574-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> With the notable caveat that in this example, mount(2) will clear all other filesystem parameters (such as MS_NOSUID or MS_NOEXEC); fsconfig(2) will only modify the ro parameter.

MS_NOSUID and MS_NOEXEC are not filesystem parameters. They can be set per-mount, but not
per-filesystem. Here is list of all filesystem-agnostic per-superblock parameters:

https://elixir.bootlin.com/linux/v6.17-rc6/source/fs/namespace.c#L4103

Note that these SB_* constants are equal to corresponding MS_* constants.

As you can see, there is no NOSUID and NOEXEC in that list.

Also, SB_NOSUID does exist:
https://elixir.bootlin.com/linux/v6.17-rc6/source/include/linux/fs.h#L1240
.

So, it seems that "NOSUID superblock" does exist as a concept. But, thanks to
code in path_mount (provided above) user cannot (in filesystem-agnostic way)
make given superblock NOSUID.

So, from user point of view, NOSUID and NOEXEC are not filesystem parameters.

If you need some example of filesystem parameter, I suggest MS_SYNCHRONOUS,
I used it here:
https://lore.kernel.org/all/198d1f2e189.11dbac16b2998.3847935512688537521@zohomail.com/

-- 
Askar Safin

