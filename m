Return-Path: <linux-api+bounces-5655-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31AD3B657
	for <lists+linux-api@lfdr.de>; Mon, 19 Jan 2026 19:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E6803001CA5
	for <lists+linux-api@lfdr.de>; Mon, 19 Jan 2026 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE038F224;
	Mon, 19 Jan 2026 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGebSY8o"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A332C31D
	for <linux-api@vger.kernel.org>; Mon, 19 Jan 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849003; cv=none; b=m2Khxoys1cF/klH4Y78bZT+ztS4ua19IyL1udtmGy5XC7NQGb2lu6GJVoCATOZsFdCL7lY5ptZ83dVEwragSwMAZdQh214xflpPSalClWQFyvexfdiX1U8YH4SzERumEmL9+7gDaffPgsqbEdJVMUTEaVDm8rcO5iFC2XQ3uuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849003; c=relaxed/simple;
	bh=bI5IPQFJ+by3IIQyhZwdLpvLyRBSEgqkFjkzhjf0OBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbOXEa6DMvbXyj1nH7jHGfM2GOMKTCkP1pA4Dxv5lEoApfUeJk0DVcroGzigP6zWPYU6TIGcuKVqECsqj8VnyqfWlFLYYfhdA1Lr/x/QiAW7purJvBw5R3vr5yn18zm95szzXK4RzEHgaIDf1XfmhEg26Ago+IK9fZFHGJ0+1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGebSY8o; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-655af782859so6759018a12.2
        for <linux-api@vger.kernel.org>; Mon, 19 Jan 2026 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768849000; x=1769453800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihXpfk6s5RJismx/mSJFIyW5r33kfZuDg7he69hJB7c=;
        b=GGebSY8oyfw+tfFlPckAmtRdNMFioP3AnzwpPbBvBGgeum3a0zf+QU30QZKcZ5AgBY
         nHs18dHOkG1hT0NuMOBCvA/5K7PWOpxflLQ6AtdohpZKw/CfUusLi/8ykpY8lMA06Hgs
         ImK+ebCoHV0CWFQ2qShkilkGeWZSAH7SfmGENV68HzKR7H9l9xqAHlTXVGBg0vnmKjay
         vud0SN9yL+AZ42wPAR98KbUW8RzRWqkhm6VK+xocWB1gY7XAEGd/sAsX8K4N1/wGDGJQ
         /VyiilYbraz9ntgm/QaEyiobElzranr0X3VUJAmJ9XVwqVL0WMIdTPnxMiouGRSDSLIm
         3HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849000; x=1769453800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihXpfk6s5RJismx/mSJFIyW5r33kfZuDg7he69hJB7c=;
        b=Sr06tQGOh1TwWx193N8K85pNKDU3CY7UqHUSskr8r+NT6gWzai5YgjNceEGZLSkf+W
         t/tP285D2X2zii7mQBu0xU4NPmflheap1eXy2eC7qeX4mVu5ACfiXyw7pwVyhsyu9xBi
         cTm6Z+SLfOxAQV/TUjsCzbfVsOePzEsRt1NaStMaMrgam3tyCu3wm3/5SIALM4qxS1Kb
         +VH08p76sDCWk6eqMS6xTwzI3o6joJk8W/AIaDHDTtBBvriCI5SscKCH1ALCo/bIAtEf
         uQC88lLk9DE1TNSdvLOSTzCz1PL7Fom+Lar5b6pvFb8pDB4nODfShWcSFAgimOvo0kr9
         9wsw==
X-Forwarded-Encrypted: i=1; AJvYcCXNluLN2naT5S3xO9bwt0HtprWxG2sUpT2Y6XkqanFF3n1QaabnlhXnXS9s6SLiIyPzow04MR1f1n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOjrBBAqNK2eOJ/VNUCcWHYIsf3ZMS84XjoPzZb+a4rn29Rtp
	sIfnXRARbAZATQs1WBum01W2+EqlGuG+Jy2eyIqFJDVn531wLaDTK0cCnNd+pw==
X-Gm-Gg: AZuq6aKwUTwclfr7YpcvMcpdxTLS6T9Uw0M1jy6kmdUAjfMAry8IQ2HXf0KaGfmZQC8
	rwdWbz64TtxavE9m615E1L7ET6MdKtVX15eMgX9bVIqPkOIwOQH6jl3FzKaP4ZFBcujn1Mv4/6v
	PLxM1OFdpEYwhVNLr+Ls8HZiJgGeWDIdAthgjJN4HcqvVMH892veS3Q0+jbqR7TTFqpFDu91JyB
	KAUcfXMwjGYJmDkPmI8BjjeiZj4o09ftU5DAKukHSrFgvANrLmtPowc3Zl293HIGdIxyJj0vurW
	GXh/T+YlhI7g9WUlJH7H85TS/05djgJdMywuGmqOIFOodDhUrEWyXO6b4r4pHbG21OIuSz4lVi+
	u8qFD2nu5EVWT7r9H2Xn33AbGFDflYBt/v9xSV7NvtVjaMKV6ywgOxaOrQQvP4h2Am0iyt6y7hA
	d+n2Jcb9oF2+RdjQDaKA==
X-Received: by 2002:a05:6000:613:b0:432:586f:2ab9 with SMTP id ffacd0b85a97d-435699787cdmr17106815f8f.5.1768842854026;
        Mon, 19 Jan 2026 09:14:14 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43569922032sm25380858f8f.8.2026.01.19.09.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 09:14:13 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	cyphar@cyphar.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Lennart Poettering <mzxreary@0pointer.de>,
	David Howells <dhowells@redhat.com>,
	Zhang Yunkai <zhang.yunkai@zte.com.cn>,
	cgel.zte@gmail.com,
	Menglong Dong <menglong8.dong@gmail.com>,
	linux-kernel@vger.kernel.org,
	initramfs@vger.kernel.org,
	containers@lists.linux.dev,
	linux-api@vger.kernel.org,
	news@phoronix.com,
	lwn@lwn.net,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Landley <rob@landley.net>,
	emily@redcoat.dev,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Date: Mon, 19 Jan 2026 20:11:01 +0300
Message-ID: <20260119171101.3215697-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> returning a file descriptor referring to that mount tree
> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> to a new mount namespace. In that new mount namespace the copied mount
> tree has been mounted on top of a copy of the real rootfs.

I want to point at security benefits of this.

[[ TL;DR: [1] and [2] are very big changes to how mount namespaces work.
I like them, and I think they should get wider exposure. ]]

If this patchset ([1]) and [2] both land (they are both in "next" now and
likely will be submitted to mainline soon) and "nullfs_rootfs" is passed on
command line, then mount namespace created by open_tree(OPEN_TREE_NAMESPACE) will
usually contain exactly 2 mounts: nullfs and whatever was passed to
open_tree(OPEN_TREE_NAMESPACE).

This means that even if attacker somehow is able to unmount its root and
get access to underlying mounts, then the only underlying thing they will
get is nullfs.

Also this means that other mounts are not only hidden in new namespace, they
are fully absent. This prevents attacks discussed here: [3], [4].

Also this means that (assuming we have both [1] and [2] and "nullfs_rootfs"
is passed), there is no anymore hidden writable mount shared by all containers,
potentially available to attackers. This is concern raised in [5]:

> You want rootfs to be a NULLFS instead of ramfs. You don't seem to want it to
> actually _be_ a filesystem. Even with your "fix", containers could communicate
> with each _other_ through it if it becomes accessible. If a container can get
> access to an empty initramfs and write into it, it can ask/answer the question
> "Are there any other containers on this machine running stux24" and then coordinate.

Note: as well as I understand all actual security bugs are already fixed in kernel,
runc and similar tools. But still [1] and [2] reduce chances of similar bugs
in the future, and this is very good thing.

Also: [1] and [2] are pretty big changes to how mount namespaces work, so
I added more people and lists to CC.

This mail is answer to [1].

[1] https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org/
[2] https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/

[3] https://lore.kernel.org/all/rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf/
[4] https://github.com/opencontainers/runc/pull/1962
[5] https://lore.kernel.org/all/cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net/

-- 
Askar Safin

