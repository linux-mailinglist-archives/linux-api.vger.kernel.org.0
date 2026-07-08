Return-Path: <linux-api+bounces-6787-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sBugASBDTmprJwIAu9opvQ
	(envelope-from <linux-api+bounces-6787-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 14:31:28 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F75726527
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 14:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=W1gfxG4H;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6787-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6787-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94CDD3086543
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B370438FFE;
	Wed,  8 Jul 2026 12:27:34 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144443DA2D
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 12:27:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513654; cv=none; b=Sv+R8j+Z5tj/+MmIhipZALCP4UpPvuq9I6it1T7D6QJqNoMD82ot0b56TfAt6+rAXyioKtVLUWSWFeRcwvrIi8H/h3sv08H9O35B+LRChu0gUrwN85j4FcCVqnjjwcslw5R6SNgicNljTb1JEZOnmma4jbqtmPq4zxAw7eVwM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513654; c=relaxed/simple;
	bh=IUEiDGkCMZWfDul+hX6c2FSnc3Kk1KIrPYd4nQPCk4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XG7S/Ulfa9zWrsF7NoH9ZUK/wQ+H1y6e+vtLZnpKB00HfbDVxl7RQkcih06Isi4mAiFtSknhLwOrEzL0iLqu7djY5SUelt9PXjI0BIwcF22pG4OtPlEsdUJFf1TuLyRzDeMCF6+1zcZ24pxZVPtFMUqtgQqKLZxhcFHfp38/fFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1gfxG4H; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783513651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiiqEGh9BnsUsU3nU5AmIB95DOATK+nQtPQ/Q3y4DLI=;
	b=W1gfxG4HcIBYPLAea/lV9CJyGkDg11wjofrpgbT0YJgzP/QCaJ+/+BhigsjHdIN/UK1Ztq
	ZgiMXbEM8GQAjA7/rOGuVqNxNJFIvX65jkJPPCgsbS0PptnvTtB0LZXNlS2GhYiOyXMrpQ
	cMwegN8nmv+2AORRwQ2EO7l9yeDXM/E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-OulKN_SUPyONn0896hcGfw-1; Wed,
 08 Jul 2026 08:27:28 -0400
X-MC-Unique: OulKN_SUPyONn0896hcGfw-1
X-Mimecast-MFC-AGG-ID: OulKN_SUPyONn0896hcGfw_1783513647
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79D5D1955F44;
	Wed,  8 Jul 2026 12:27:27 +0000 (UTC)
Received: from localhost (unknown [10.44.33.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE4EB195606D;
	Wed,  8 Jul 2026 12:27:26 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
In-Reply-To: <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 8 Jul 2026 12:24:56 +0200")
References: <20260708095831.3381978-1-gscrivan@redhat.com>
	<CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 08 Jul 2026 14:27:25 +0200
Message-ID: <878q7l8y4y.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sea.lore.kernel.org:server fail,szeredi.hu:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6787-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46F75726527

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Wed, 8 Jul 2026 at 12:00, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>
>> Add two ioctls to overlay filesystem to allow userspace to retrieve
>> information about the overlay layers:
>>
>> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
>>                         arg == 0 returns the upper layer (-ENOENT if
>>                         no upper is configured), arg >= 1 returns
>>                         lower layers (-ENOENT if index is out of
>>                         range).
>
> We could do this with a plain open() call.  Something like the magic
> symlinks we have under /proc/PID/fd/.   Question is where could these
> live...

is there any existing user of such a mechanism?  I don't see any mount
specific info under /proc or /sys.

>
>> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
>>                         with numlower, numlowerdata, and has_upper.
>
> Isn't this info obtainable via statmount(2) already?  If not, it
> should be there, instead of a specialized ioctl.

no that is not exposed by statmount and I don't see any way to export
file system specific data through it.  Do you've anything in mind?

>> --- a/fs/overlayfs/ovl_entry.h
>> +++ b/fs/overlayfs/ovl_entry.h
>> @@ -35,6 +35,8 @@ struct ovl_layer {
>>         struct vfsmount *mnt;
>>         /* Trap in ovl inode cache */
>>         struct inode *trap;
>> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_LAYER */
>> +       struct file *origin;
>
> Don't need to keep the file open: the only info missing is the
> original vfsmount, everything else is already there to reconstruct the
> file.

I didn't manage to get that to work.  As soon as the userspace process
closes the mount fd that was passed to fsconfig, the anonymous mount
namespace is destroyed and dissolve_on_fput sets mnt->mnt_ns to NULL.

So whenever I try to use this mount again from userspace, it is not
usable because the mount namespace is empty, causing check_mnt() to
fail.

Do you have any suggestions on how to solve this problem?

Regards,
Giuseppe


