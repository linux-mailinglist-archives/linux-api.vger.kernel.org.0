Return-Path: <linux-api+bounces-6804-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aSOLDia4TmrDSwIAu9opvQ
	(envelope-from <linux-api+bounces-6804-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 22:50:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6177C72A540
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 22:50:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Pi3O664O;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6804-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6804-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFBF930D0F3F
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7E3EB114;
	Wed,  8 Jul 2026 20:45:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540273EB7E5
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 20:45:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543542; cv=none; b=GrtUgJPBWuZ2dkomBgOUEJgrcy0PNPgdXIXlkmIN/PgocgoId+W/7uGA5+H9qj/WO4Z4xsNoWb6tDHpPvmIjJ2SNAeAwJwmzDtHB31iHX6nFs+dhdkGWEA2Z40Q2aameyPL2DnP1GxVMKG/MZS9S3gPIRezDb44OzzqFMn8lh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543542; c=relaxed/simple;
	bh=HqIB2Kot+cSx6M46cVPe/gTQ8inr8AvF9kCYwuMxRpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzHtYGb5wab/ttUe+ErCopxG4XqaWfUGgEg7eguDnk3uL/6Lw6tQGe2lKKDX3K1IwGe4xFQxYWPZsCoHp4z218XQPIkzxsnBdYPQywmtadRgHujH6nTOGIDiPTawxy/5HkXH5zZlncgWgHAqOqeI6oC3M3nSowIOhO621MmE9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pi3O664O; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783543539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUGOXr6bxTzxRUQM7JAmFPIE9TMkzlb5J7p/wDZven8=;
	b=Pi3O664OywhAPYp+V+KQv2OJUcMzF7uabWRkikrc2dIddJHJTQPqwb5v0w9ru8aF0b3oYS
	2xbAduK2A6j//SVuB2NUQcuNDVJTMmjA9Cc+yxmoyWE0X9qY8VoAlq/1X26SpTNaVH9tMb
	YPvWWYUGidf4sd+KGap1Xw2Jh5/FSIQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-KDo1jjHIMWOaypUKFyLqkQ-1; Wed,
 08 Jul 2026 16:45:36 -0400
X-MC-Unique: KDo1jjHIMWOaypUKFyLqkQ-1
X-Mimecast-MFC-AGG-ID: KDo1jjHIMWOaypUKFyLqkQ_1783543535
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13B781800630;
	Wed,  8 Jul 2026 20:45:35 +0000 (UTC)
Received: from localhost (unknown [10.44.33.4])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 894853692D;
	Wed,  8 Jul 2026 20:45:34 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  linux-unionfs@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-api@vger.kernel.org
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
In-Reply-To: <CAJfpegvtd--TEQP9CVjSZuosU4meELdzhTV9oFo6joR1f4Dpgw@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 8 Jul 2026 16:01:38 +0200")
References: <20260708095831.3381978-1-gscrivan@redhat.com>
	<CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
	<878q7l8y4y.fsf@redhat.com>
	<CAOQ4uxiiVsp0BsdqfH3rCrpP6fBi-vTyfXd-TcVmFcS34MxzUQ@mail.gmail.com>
	<871pdd8ukx.fsf@redhat.com>
	<CAJfpegvtd--TEQP9CVjSZuosU4meELdzhTV9oFo6joR1f4Dpgw@mail.gmail.com>
Date: Wed, 08 Jul 2026 22:45:32 +0200
Message-ID: <87bjch6wib.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6804-lists,linux-api=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:amir73il@gmail.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 6177C72A540

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Wed, 8 Jul 2026 at 15:44, Giuseppe Scrivano <gscrivan@redhat.com> wrot=
e:
>>
>> Amir Goldstein <amir73il@gmail.com> writes:
>>
>> > On Wed, Jul 8, 2026 at 2:31=E2=80=AFPM Giuseppe Scrivano <gscrivan@red=
hat.com> wrote:
>> >>
>> >> Miklos Szeredi <miklos@szeredi.hu> writes:
>> >>
>> >> > On Wed, 8 Jul 2026 at 12:00, Giuseppe Scrivano <gscrivan@redhat.com=
> wrote:
>> >> >>
>> >> >> Add two ioctls to overlay filesystem to allow userspace to retrieve
>> >> >> information about the overlay layers:
>> >> >>
>> >> >> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
>> >> >>                         arg =3D=3D 0 returns the upper layer (-ENO=
ENT if
>> >> >>                         no upper is configured), arg >=3D 1 returns
>> >> >>                         lower layers (-ENOENT if index is out of
>> >> >>                         range).
>> >> >
>> >> > We could do this with a plain open() call.  Something like the magic
>> >> > symlinks we have under /proc/PID/fd/.   Question is where could the=
se
>> >> > live...
>> >>
>> >> is there any existing user of such a mechanism?  I don't see any mount
>> >> specific info under /proc or /sys.
>> >>
>> >> >
>> >> >> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
>> >> >>                         with numlower, numlowerdata, and has_upper.
>> >> >
>> >> > Isn't this info obtainable via statmount(2) already?  If not, it
>> >> > should be there, instead of a specialized ioctl.
>> >>
>> >> no that is not exposed by statmount and I don't see any way to export
>> >> file system specific data through it.  Do you've anything in mind?
>> >>
>> >> >> --- a/fs/overlayfs/ovl_entry.h
>> >> >> +++ b/fs/overlayfs/ovl_entry.h
>> >> >> @@ -35,6 +35,8 @@ struct ovl_layer {
>> >> >>         struct vfsmount *mnt;
>> >> >>         /* Trap in ovl inode cache */
>> >> >>         struct inode *trap;
>> >> >> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_=
LAYER */
>> >> >> +       struct file *origin;
>> >> >
>> >> > Don't need to keep the file open: the only info missing is the
>> >> > original vfsmount, everything else is already there to reconstruct =
the
>> >> > file.
>> >>
>> >> I didn't manage to get that to work.  As soon as the userspace process
>> >> closes the mount fd that was passed to fsconfig, the anonymous mount
>> >> namespace is destroyed and dissolve_on_fput sets mnt->mnt_ns to NULL.
>> >>
>> >> So whenever I try to use this mount again from userspace, it is not
>> >> usable because the mount namespace is empty, causing check_mnt() to
>> >> fail.
>> >>
>> >> Do you have any suggestions on how to solve this problem?
>> >
>> > The suggestion was to store origin->f_path->mnt instead of storing ori=
gin file,
>> > because you only end up using the origin vfsmount.
>>
>> the reason I am keeping the file and not just the vfsmount is that the
>> file is what keeps the mount namespace alive (preventing
>> dissolve_on_fput from fire).
>>
>> Should we export open_detached_copy from fs/namespace.c?  I've not
>> tested it, but it might work.  Are there other ways to solve it that I
>> am not seeing?
>
> Using an anon namespace sounds good to me, that means the original
> vfsmount isn't needed at all.
>
> Not sure if it's okay for the case where the original ns is not anon,
> but we can save the vfsmount in that case if it turns out to be a
> problem.
>
> Thanks,
> Miklos

for this to work, I need something like:

diff --git a/fs/namespace.c b/fs/namespace.c
index 3d5cd5bf3b05..138d15ab37ef 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3091,6 +3091,52 @@ static struct file *open_detached_copy(struct path *=
path, unsigned int flags)
 	return file;
 }
=20
+struct file *open_detached_copy_internal(struct path *path)
+{
+	struct mnt_namespace *ns, *mnt_ns =3D current->nsproxy->mnt_ns;
+	struct mount *mnt;
+	struct file *file;
+
+	ns =3D alloc_mnt_ns(mnt_ns->user_ns, true);
+	if (IS_ERR(ns))
+		return ERR_CAST(ns);
+
+	guard(namespace_excl)();
+
+	mnt =3D clone_mnt(real_mount(path->mnt), path->dentry,
+			CL_COPY_MNT_NS_FILE);
+	if (IS_ERR(mnt)) {
+		free_mnt_ns(ns);
+		return ERR_CAST(mnt);
+	}
+
+	mnt_add_to_ns(ns, mnt);
+	ns->nr_mounts++;
+	ns->root =3D mnt;
+
+	mntput(path->mnt);
+	path->mnt =3D mntget(&mnt->mnt);
+	file =3D dentry_open(path, O_PATH, current_cred());
+	if (IS_ERR(file))
+		dissolve_on_fput(path->mnt);
+	else
+		file->f_mode |=3D FMODE_NEED_UNMOUNT;
+	return file;
+}
+EXPORT_SYMBOL_GPL(open_detached_copy_internal);
+
 enum mount_copy_flags_t {
 	MOUNT_COPY_RECURSIVE    =3D (1 << 0),
 	MOUNT_COPY_NEW		=3D (1 << 1),

is this acceptable?

Regards,
Giuseppe


