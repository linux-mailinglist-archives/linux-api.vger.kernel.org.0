Return-Path: <linux-api+bounces-5137-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC8BFAE1E
	for <lists+linux-api@lfdr.de>; Wed, 22 Oct 2025 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629063B2EE9
	for <lists+linux-api@lfdr.de>; Wed, 22 Oct 2025 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140BF309DCB;
	Wed, 22 Oct 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9lSf9jl"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99574309DC6
	for <linux-api@vger.kernel.org>; Wed, 22 Oct 2025 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121578; cv=none; b=q8quRKG7yIaPKiL6/76aDcbS/aHUhFte5aymoCf1O1d5/wBeH8qz+oqDGloJ0ZhnPabwXIzPUxkd0VU3MFw46pVB+X9eOFjSJIB9TdwriHPUUffNmp5tmibLs9v+08mfGphbXmE6dvYFoa46QcJh6ckJ3SNqyn5RLkXg6IlVqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121578; c=relaxed/simple;
	bh=Q6H986X15qYys1qfZkB9W2dW8AtLZxTL9G3Hoa0FETk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVutKIZnzhOM7p04F2rYXfy9tmwRWKRmPN409nQtzuy1ZYS1R9mSh4zSWx9wy8VfwVyo8l/ALcUhb7yU2W+tMMC4bJilfBrOzflMSlaKlmEY5nKdEQ3MNQ/jC+iJfv64uGStFwBHgsG+rb63zbPecBScSeGWXTyTXpDUV/xUIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9lSf9jl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so1359540866b.3
        for <linux-api@vger.kernel.org>; Wed, 22 Oct 2025 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761121574; x=1761726374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDyEa99uEXhpux+y1jdsG/DCyMfzL2pd992wei+/e1g=;
        b=g9lSf9jlzTL74ZxyfEMsa16zdauZydvqbq6C8BlT0oq+R+RCOZKV7QlN+n7Puwk6X9
         TK11E1pXhHLdAuoU9qJ8OVl+4QcN5CIDLdvrtHDuaQdch6/it+z8DAx58sBJnRfAmgVz
         vG4xalYkaDCAiv6gJpIiu08tQML8GZKeBJuCErAqp862qz7oIFTxEML3NDQfa42+q1m5
         JyZrQGPFKnbdBW9dDJ4+v/Qb2AY9ddKozGeODolVFc91lLhGagiEvJAxutp+Fa0TKdf+
         VbXPxrycqhr9LTv3VpU2DzC8PZWvGeSgNpfGHO24xPNLpypRN3tDJdofqxE6Q/w05re7
         zT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121574; x=1761726374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDyEa99uEXhpux+y1jdsG/DCyMfzL2pd992wei+/e1g=;
        b=n1dckg/MoCF0rPTESUYzEuhbDy7YipNSkBhVm9qFUVorohjf0x5XP/02uBy5eK1bjR
         EnGuMGoiqJE+hrJbw5fLjfzqFNjvrpGlg3Hc5mi0+4e668G8bsG2H6Lhlst9G+yMUzs/
         usQnmatqS9VnzhF9t7vSKwburOn6n0Bmp6KXToPpO/sqYdEjsPRNK10VfIBhy51HSky2
         zBpWah1awFI2qsgG4cU0YMAu4DEZOikzYLRCq06gScna8r55ZjKFRMXUUhTkqKHCrwAD
         oItxSCvj/9ZHz8w8YZUDo7AbFlVcKRbYtiSe1+VHh7h7JQTW7suyQdADehH0cn+PzbxK
         x23g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2Arr6mjxPgdMvKgfdRh4/QWuOIuraNLYwDAA1980ttPcz4C63a0FyO+63QWkZlzoKCsVMf13pBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1IdJVjVGalu8xfcwBn7ZCSx4I7Kpsl0OBrybkEdm/mz6gP2+k
	JvXtPFi4okFn5vwuxRgcqwGsCbVVvbd24jA0K0mxXt+zKqrUUtV6wPC3
X-Gm-Gg: ASbGncuzLro19evui/+z6MK/uNseDboQ1EMcQNHrv5j6bePSmu1VU0ET655fO/G4CKs
	NOUvlFMm3IjdU1goSMOTVusohddt9xs2vBloMhZtaVZ+ijAx8trN/aco3uKxDJSvKUACRm99Gsy
	dR+LDN0NxWtD3vmMGa6KGyWuRhguZwncR1QmRqW2o+bFh559NXYfpUvwjSrRSKQWB+bS3J/R6QC
	TqrvgkKpOjBtExFsYaDPxrmz2csqfGkk8c+TlvlSLWDjC5GkC6tKxSGiyjnK3zvlAK0NHcFw5XU
	QFdEgemsk/x5gHseTdBzvSpGkkVly4fa4nBbZlX5SSIDD25OlCz0OyJLK8XqH/NoGLyoJ8FcRoq
	RJdicldhgTyJip/uxzSUCyLIRTW+qhn/tAojtEUuhuq0oMSbo0wfSX9/Ya5WT9/RGYbQIONtWN6
	rH
X-Google-Smtp-Source: AGHT+IFMC1ZTRJ80d2+tQCzLJZEUcRjgNolpnafRAvb1tXsgv9lX8RVp0jdHUx6GvU3poKNRSafE7g==
X-Received: by 2002:a17:907:7ea6:b0:b3e:3c1c:d2f2 with SMTP id a640c23a62f3a-b6474940fc1mr2581204566b.36.1761121573582;
        Wed, 22 Oct 2025 01:26:13 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6cfa6cb6e6sm365510866b.49.2025.10.22.01.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:26:13 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: hch@infradead.org
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	arnd@arndb.de,
	axboe@kernel.dk,
	bp@alien8.de,
	brauner@kernel.org,
	christophe.leroy@csgroup.eu,
	cyphar@cyphar.com,
	ddiss@suse.de,
	dyoung@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	jrtc27@jrtc27.com,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	krzk@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	nschichan@freebox.fr,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 0/3] initrd: remove half of classic initrd support
Date: Wed, 22 Oct 2025 11:26:04 +0300
Message-ID: <20251022082604.25437-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aPh9Tx95Yhm_EkLN@infradead.org>
References: <aPh9Tx95Yhm_EkLN@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christoph Hellwig <hch@infradead.org>:
> On Tue, Oct 21, 2025 at 03:05:35PM +0200, Christian Brauner wrote:
> > Without Acks or buy-in from other maintainers this is not a change we
> > can just do given that a few people already piped up and expressed
> > reservations that this would be doable for them.
> > 
> > @Christoph, you marked this as deprecated years ago.
> > What's your take on this?
> 
> I'd love to see it go obviously.  But IIRC we had various users show
> up, which speaks against removing it.  Maybe the first step would be
> a separate config option just for block-based initrd?

So far in recent months 3 people spoke against initrd removal. All they are in Cc. They are:

- Julian Stecklina. He planned to use initrd with erofs, which is currently
not supported anyway. Also, he replied to v1:
"You have all my support for nuking so much legacy code!"
"Acked-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>"
( https://lore.kernel.org/lkml/1f9aee6090716db537e9911685904786b030111f.camel@cyberus-technology.de/ )

- Gao Xiang, maintainer of erofs. He also planned to use initrd with erofs,
which is currently not supported anyway. Also, he said to me:
> Again, I don't have any strong opinion to kill initrd entirely because
> I think initdax may be more efficient and I don't have any time to work
> on this part -- it's unrelated to my job.
( https://lore.kernel.org/all/79315382-5ba8-42c1-ad03-5cb448b23b72@linux.alibaba.com/ )

- Nicolas Schichan. He has million devices, which use initrd. But they use
root=/dev/ram code path, not linuxrc code path, which I'm removing. He
explained this here:
https://lore.kernel.org/lkml/20250918152830.438554-1-nschichan@freebox.fr/

So, this patchset will not impact these people. So, I think it is okay
to remove linuxrc now. We can revert this patchset if needed.

-- 
Askar Safin

