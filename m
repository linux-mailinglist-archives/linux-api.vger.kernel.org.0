Return-Path: <linux-api+bounces-4139-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F46AFB2DD
	for <lists+linux-api@lfdr.de>; Mon,  7 Jul 2025 14:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B3616FDDD
	for <lists+linux-api@lfdr.de>; Mon,  7 Jul 2025 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97DB29AAEA;
	Mon,  7 Jul 2025 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUuTeRz/"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44596285CB8
	for <linux-api@vger.kernel.org>; Mon,  7 Jul 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889918; cv=none; b=PERpXeTCPNpVtF/DicySkY3LAW7lTNrwV14QqBHVZStMO5N8ysk41STdYqnkuZnEhOA6QjvLXFUHP2SUBXUQDfMUS+YjwmpsgS3izrxHQNXImHayCwL6MzKcYzVhkcaOjhhBD0ciMKV03ArA4urJ8eCbUuhaDvh92cLtuV3kIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889918; c=relaxed/simple;
	bh=yShfZ6ILsOBhd6koGDWWiQzQZWiggGZJjghyucsosDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6NG7VOKZTrTRdqFpA9mgzjBN7eUfn82J0eE2cfwPNi6cKvyEcCFfDGk0Z3TzrvoXbTdLQoYVq2NkG8T/+LbGESFbFWZlIicft5KajAcnBOCMjLdHlMdAw70i1ebv/paYb6gbyvQbnbotBd/4hX5qdU6HVJwlaYjlpga70KbNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUuTeRz/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751889916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2coxbyxFXdSQKENSeYoc+GW9sQUhtsiwwJEzAsI5vW4=;
	b=GUuTeRz/1jL60rqYhhwFuCF3D8ZgG0DR0ORAgKlB6BHDyYn2EAq/CrVF/ro22+Wg9rDp0x
	OftMwoOFpRg+AVDThCbZReh2GKWsjZ8yNBdsVLOr1W4sRhOKB9PbQkd+kvj7ywBEL+2Eak
	YmbSY70crQZigGsQDvZ/eP/q+OSEuQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-4FvVN0tFNXKLvphYunoYtA-1; Mon, 07 Jul 2025 08:05:13 -0400
X-MC-Unique: 4FvVN0tFNXKLvphYunoYtA-1
X-Mimecast-MFC-AGG-ID: 4FvVN0tFNXKLvphYunoYtA_1751889912
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso1384392f8f.3
        for <linux-api@vger.kernel.org>; Mon, 07 Jul 2025 05:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751889912; x=1752494712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2coxbyxFXdSQKENSeYoc+GW9sQUhtsiwwJEzAsI5vW4=;
        b=BR1i+0pm+/69YQxT152eF9lnBbJo8YfZnMXAwr5ACA3N5h8MyhKQw1EdCEsxsDbGJy
         jHQC/7kXoeoQ3MRUuyMyHZNSkhAo7F6ORLG8HT1bDtaxeo2MyYb6JCVrKF1vzTbp4wXU
         9y/JZMFCGFZwbWhJLvH5+R1q81x9GmSmlR/mVq2g8dKo0nVp/1NzqM8dbgPduTu/ijWo
         LQKWJdw8Y2UxGQcKeakLqEo9TnLOa8n0b8BXR95hN6CwOxlaB+Qvp1YDxQHn2gAU0kAO
         x7XblGhsrbKD+KLIjGsbgG53AyE30IWgiesHt9KhbrcQTs1Wxiw6h1SaK9zpI3Vw1oQ+
         ZpzA==
X-Forwarded-Encrypted: i=1; AJvYcCXd7SzoOEgt2Dq1Xwa+AfxAhhHaKwqYFCWF6BipCCvkL48od/4/zxixqxCCrYsU6zvaxqJtHEO55/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCCXwdhX0JCOh5E6VCPGyGz52E+3RJ++pMsmiJudz532nRIUz
	3XDa1NEHDXyGPRnezd+NcDgemMyMBEHOqhpmdMyaTJnCz1JFs2GxvSNgfmy8Jb2PKHmZtXCXJcG
	JMEmHvcBf3egeCZLHOTsC7lShjCU7fdBTT5CJzybQ+CFkflutFdS4BsNqYnkb
X-Gm-Gg: ASbGncuS0iq5xpfx0uX2Y1At/fsgkIvpFQUXoChjVi+dSlDFTtpx86SdPqmpxAfpM06
	JqlCKL8jIZkVPxfA5hdKV7PeTTV9wd0zcLs7omo8LuXctAsnLdJWbs+c56kduzM+tWWcyQk4HrT
	ucslj4laWXDnsmvhuxE9X0y6MRROCRMmn+smn+4b3UC2clN4xcdpEzRhrlv4yK90KArvdLiYsXh
	2XcfXUeHXthRMUwTkJaQ7dgUuAijv/5ZFS2sb2JpPVeKvRnpJ2eOlzt3XTxfnsBQc1ZlO6aBfZG
	8erFVNAYDB2zZvKcmZPLi5jmcQM5KCEC+r6yGQWNmQ==
X-Received: by 2002:adf:e18c:0:b0:3a4:d274:1d9b with SMTP id ffacd0b85a97d-3b49aa306c7mr7357368f8f.25.1751889912210;
        Mon, 07 Jul 2025 05:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEi5xHzfaruNNWM5Xa5nbbHvwTT5Ypm3IkOF4wO8OCiHtSnJRFyxUTJ6ZrNFQU7wWPBnE0rg==
X-Received: by 2002:adf:e18c:0:b0:3a4:d274:1d9b with SMTP id ffacd0b85a97d-3b49aa306c7mr7357295f8f.25.1751889911645;
        Mon, 07 Jul 2025 05:05:11 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0959sm9902891f8f.27.2025.07.07.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 05:05:11 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:05:10 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <uzx3pdg2hz44n7qej5rlxejdmb25jny6tbv43as7dos4dit5nv@fyyvminolae6>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250701-quittung-garnieren-ceaf58dcb762@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-quittung-garnieren-ceaf58dcb762@brauner>

On 2025-07-01 14:29:42, Christian Brauner wrote:
> On Mon, Jun 30, 2025 at 06:20:10PM +0200, Andrey Albershteyn wrote:
> > This patchset introduced two new syscalls file_getattr() and
> > file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> > except they use *at() semantics. Therefore, there's no need to open the
> > file to get a fd.
> > 
> > These syscalls allow userspace to set filesystem inode attributes on
> > special files. One of the usage examples is XFS quota projects.
> > 
> > XFS has project quotas which could be attached to a directory. All
> > new inodes in these directories inherit project ID set on parent
> > directory.
> > 
> > The project is created from userspace by opening and calling
> > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > with empty project ID. Those inodes then are not shown in the quota
> > accounting but still exist in the directory. This is not critical but in
> > the case when special files are created in the directory with already
> > existing project quota, these new inodes inherit extended attributes.
> > This creates a mix of special files with and without attributes.
> > Moreover, special files with attributes don't have a possibility to
> > become clear or change the attributes. This, in turn, prevents userspace
> > from re-creating quota project on these existing files.
> 
> Only small nits I'm going to comment on that I can fix myself.
> Otherwise looks great.
> 

Hi Christian,

Let me know if you would like a new revision with all the comments
included (and your patch on file_kattr rename) or you good with
applying them while commit

-- 
- Andrey


