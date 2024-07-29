Return-Path: <linux-api+bounces-2042-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA8793F9AD
	for <lists+linux-api@lfdr.de>; Mon, 29 Jul 2024 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B622028336C
	for <lists+linux-api@lfdr.de>; Mon, 29 Jul 2024 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419715A87C;
	Mon, 29 Jul 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLxiCGKo"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C4823A9
	for <linux-api@vger.kernel.org>; Mon, 29 Jul 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267580; cv=none; b=Nnta5M/Je2n/pxZjzyKLSYGzA8RasxPWEIbVdruJUjnAbhh2JbUmy/TJ3ns/AIv99CLp8cfCLFeGjnUQB5xOFsdl/tRGHjGge+Lj7bSyO8ndvkfGRRkL/HwCRRahJYGI1rsEVMLWZDHGVvvfrIyAMbuiV4ykddnKcJ54dmi/tKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267580; c=relaxed/simple;
	bh=Km4f0/3Vzz+8Qh1fHaeNKmN2Y2DZ97pJ0lZw8d2Z8gY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EkCJBwhVlrJllOW//K4aPcc4kKJSdTDMBuaiYQET2cNQEI0tCk2aI8/3b585zZQ2YQcBHmyreKX2nsEADCoOTqc7cZ8uGfkv212RAL29DmNHnYkgMmqlBbRBw1eaDhAJFU9eOX+WU/DzDh5bWx2epdBnucddBvvNdE8thJRqpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLxiCGKo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722267577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTv5CfW4HXbVM7xQU93V1CPvEqo/zJ6yCu/2thM1qdY=;
	b=aLxiCGKoZ8xJUsuWszTSsMdJA3kRTGccSpx1CUDFSFaxTrWj656zb8/QTk1hwmCJXqTAWc
	/vSq5E+FicveYYdvWASbufzHil8MT3lj3fl0ueAN/RGi6GikAGtgb/OFqI3RM768DLL1ub
	sTVHut/ZqNGnHNJl5v31RHXnR/bjwPI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-kAsn5MPIMMm01t7Y-2XajQ-1; Mon,
 29 Jul 2024 11:39:34 -0400
X-MC-Unique: kAsn5MPIMMm01t7Y-2XajQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9617D1955D5F;
	Mon, 29 Jul 2024 15:39:33 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88EEB1955F40;
	Mon, 29 Jul 2024 15:39:31 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
In-Reply-To: <a13bff5812cb36adf3fed80093cbe1de601ec506.camel@kernel.org> (Jeff
	Layton's message of "Mon, 29 Jul 2024 11:24:41 -0400")
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
	<a13bff5812cb36adf3fed80093cbe1de601ec506.camel@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 29 Jul 2024 17:39:28 +0200
Message-ID: <87frrsmclr.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Jeff Layton:

> On Mon, 2024-07-29 at 08:55 +0200, Florian Weimer wrote:
>> It was pointed out to me that inode numbers on Linux are no longer
>> expected to be unique per file system, even for local file systems.
>> Applications sometimes need to check if two (open) files are the
>> same.
>> For example, a program may want to use a temporary file if is invoked
>> with input and output files referring to the same file.
>>=20
>> How can we check for this?=C2=A0 The POSIX way is to compare st_ino and
>> st_dev in stat output, but if inode numbers are not unique, that will
>> result in files falsely being reported as identical.=C2=A0 It's harmless
>> in
>> the temporary file case, but it in other scenarios, it may result in
>> data loss.
>>=20
>
> I believe this is the problem that STATX_SUBVOL was intended to solve.
>
> Both bcachefs and btrfs will provide this attribute if requested. So,
> basically to uniquely ID an inode using statx, you need a tuple of:
>
> stx_dev_major/minor
> stx_subvol
> stx_ino
>
> If the filesystem doesn't provide STATX_SUBVOL, then one can (likely)
> conclude that stx_dev_* and stx_ino are enough.

Does this really work for the virtiofs case, though?  It has to pass
through all three *and* make things unique relative to the host, I
think.

Thanks,
Florian


