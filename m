Return-Path: <linux-api+bounces-6791-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5FGyCUFUTmo1KwIAu9opvQ
	(envelope-from <linux-api+bounces-6791-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 15:44:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 884DB726EAB
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 15:44:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KZXmQdRc;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6791-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6791-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90ECD3017F86
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D837F8DD;
	Wed,  8 Jul 2026 13:44:24 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5F3033DE
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 13:44:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518264; cv=none; b=hbfcIFWD3Ye0bq34NCroIF2IRXlOMUYCY2xVFtzh6sqFCPXqClK4GI7FvwNAkpa7cZgTzqFg+fW6CtOsgl3q6vQntxDBaV0U9263DotBz/E/XqWSS5MxrsAVmX3/lcFq/gdoRGpQRP9unDA+bKLh6GLmLWKvKWRlbIp9Rm8yZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518264; c=relaxed/simple;
	bh=YsBaplu3SMyqS5ChwAscmwg7/sP4A3KtcN3vsRP2+do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fwf0cKTCUMlUoTO+7tQRZZZ6I9jGcKaxwKiayaLI1KG64iv9bVXcFD9clU02N11MiXGkzOXJt27GKJ8P6/GBpSlkSA/2LQ3c7NrQrK7I61azJ9mr7BsrAZ17iUp/hEWI4FOtcgQjuY0VtEIw/PvzAuWXP46UORhywW5saCOeGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZXmQdRc; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783518261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MQQ1awMEWZQP75HQCTbVtUf+Uu2HSLb/C+A8UOw06U=;
	b=KZXmQdRcIltZIv67/e5GuI9GgoaU3IYshRygVOWYjgNp9BkETQ3pdNyX5qIxQQl0wyWtR5
	8qhpPe5A8NIcF4JsAERDusmaGayXcMw8noXuQ+Hw9cB5VNypjRznbpWNBA4lB5u8YXunb0
	WZNJpx/8uEqOpskLGMEwuzoPHpg+CQA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-koEbMCitOZKS5lRLZMc2EQ-1; Wed,
 08 Jul 2026 09:44:19 -0400
X-MC-Unique: koEbMCitOZKS5lRLZMc2EQ-1
X-Mimecast-MFC-AGG-ID: koEbMCitOZKS5lRLZMc2EQ_1783518258
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F56A19560B7;
	Wed,  8 Jul 2026 13:44:18 +0000 (UTC)
Received: from localhost (unknown [10.44.33.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54FEC1800591;
	Wed,  8 Jul 2026 13:44:17 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-unionfs@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-api@vger.kernel.org
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
In-Reply-To: <CAOQ4uxiiVsp0BsdqfH3rCrpP6fBi-vTyfXd-TcVmFcS34MxzUQ@mail.gmail.com>
	(Amir Goldstein's message of "Wed, 8 Jul 2026 15:23:46 +0200")
References: <20260708095831.3381978-1-gscrivan@redhat.com>
	<CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
	<878q7l8y4y.fsf@redhat.com>
	<CAOQ4uxiiVsp0BsdqfH3rCrpP6fBi-vTyfXd-TcVmFcS34MxzUQ@mail.gmail.com>
Date: Wed, 08 Jul 2026 15:44:14 +0200
Message-ID: <871pdd8ukx.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:miklos@szeredi.hu,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-6791-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 884DB726EAB

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Jul 8, 2026 at 2:31=E2=80=AFPM Giuseppe Scrivano <gscrivan@redhat=
.com> wrote:
>>
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>>
>> > On Wed, 8 Jul 2026 at 12:00, Giuseppe Scrivano <gscrivan@redhat.com> w=
rote:
>> >>
>> >> Add two ioctls to overlay filesystem to allow userspace to retrieve
>> >> information about the overlay layers:
>> >>
>> >> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
>> >>                         arg =3D=3D 0 returns the upper layer (-ENOENT=
 if
>> >>                         no upper is configured), arg >=3D 1 returns
>> >>                         lower layers (-ENOENT if index is out of
>> >>                         range).
>> >
>> > We could do this with a plain open() call.  Something like the magic
>> > symlinks we have under /proc/PID/fd/.   Question is where could these
>> > live...
>>
>> is there any existing user of such a mechanism?  I don't see any mount
>> specific info under /proc or /sys.
>>
>> >
>> >> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
>> >>                         with numlower, numlowerdata, and has_upper.
>> >
>> > Isn't this info obtainable via statmount(2) already?  If not, it
>> > should be there, instead of a specialized ioctl.
>>
>> no that is not exposed by statmount and I don't see any way to export
>> file system specific data through it.  Do you've anything in mind?
>>
>> >> --- a/fs/overlayfs/ovl_entry.h
>> >> +++ b/fs/overlayfs/ovl_entry.h
>> >> @@ -35,6 +35,8 @@ struct ovl_layer {
>> >>         struct vfsmount *mnt;
>> >>         /* Trap in ovl inode cache */
>> >>         struct inode *trap;
>> >> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_LAY=
ER */
>> >> +       struct file *origin;
>> >
>> > Don't need to keep the file open: the only info missing is the
>> > original vfsmount, everything else is already there to reconstruct the
>> > file.
>>
>> I didn't manage to get that to work.  As soon as the userspace process
>> closes the mount fd that was passed to fsconfig, the anonymous mount
>> namespace is destroyed and dissolve_on_fput sets mnt->mnt_ns to NULL.
>>
>> So whenever I try to use this mount again from userspace, it is not
>> usable because the mount namespace is empty, causing check_mnt() to
>> fail.
>>
>> Do you have any suggestions on how to solve this problem?
>
> The suggestion was to store origin->f_path->mnt instead of storing origin=
 file,
> because you only end up using the origin vfsmount.

the reason I am keeping the file and not just the vfsmount is that the
file is what keeps the mount namespace alive (preventing
dissolve_on_fput from fire).

Should we export open_detached_copy from fs/namespace.c?  I've not
tested it, but it might work.  Are there other ways to solve it that I
am not seeing?

Thanks,
Giuseppe


