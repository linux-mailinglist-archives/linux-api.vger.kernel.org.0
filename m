Return-Path: <linux-api+bounces-6166-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCMCKSFC62nZKAAAu9opvQ
	(envelope-from <linux-api+bounces-6166-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 12:12:49 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D72D45CCBB
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 365EE302DA2A
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91643624CB;
	Fri, 24 Apr 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em4CyCcr"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8A36309C
	for <linux-api@vger.kernel.org>; Fri, 24 Apr 2026 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777025377; cv=none; b=GvZEUyozvf+jDJGUyHukMs3qgqWJyBDSKn0vw8DP3/ef5gFpLvOff2J8gtpeZoP5sWnp+92mDoL3Wxo0w7SCBfHIknIMnG4ceSE/L8hAex06Ru+8YsixMu6YGF5+M90RpwS9FAA0cBhpyEdY5QEo8G+757QZMdTulWynN60DSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777025377; c=relaxed/simple;
	bh=RnpfrNhB3ccXPzS/+ABSINI7IqvVsyrA7HPYJ6nIkKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFtVWbxvZAf3n5Ul7vl8VOl3pMzVmzvYs5tp0h/bnJ59zAIahSvhEsxIGBgDOXHTj0EmkioRvCcJFnsn/xMPzZYN4SmB7lZPO05y5yyhxHIyphkFxQq0A8Czcv9P0r31ln8GwuUQjVDC90OovlMfMFBe/pJSDcUl4lCiRiuABdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em4CyCcr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1033062166b.1
        for <linux-api@vger.kernel.org>; Fri, 24 Apr 2026 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777025374; x=1777630174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNHGdIi7azttvOU0ihx56z2No45BL/OntYqLbzQGkko=;
        b=em4CyCcrvXWZqUelsCcZXp7mVosMq3b/5qmbse4Mm3nVBQi9c0tyHcnSNxaIQdAyhD
         dJrdQk58qQp9yb3VDIosnoUNRoBySsQ24LCe71YTU0BDdKOjqXTHlurx5HDjmz2BNZJs
         lTNXDHuiyNPWTTIxi0iVkcVLJsBnsXgOC6gUWFITXjARgnYeYWTpmcn766s8q1GCYwoV
         qLWrGckVo8i8NGESUgnAEQHAHTIWBLWxeik65XizG8KTE7g10xByw2Emcw+GZpnw/DWf
         b+9JfCnHiKu8krbcJ5ko608uEIRAHtcn23aaoA3NgW4VlTzbbNY/az7Hp0cxG2moDBIm
         cADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777025374; x=1777630174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNHGdIi7azttvOU0ihx56z2No45BL/OntYqLbzQGkko=;
        b=RO2JJ32mB502VQf/a255kl6CLTnu87e1E7svRFPq3+KVVc+NjX3v6AzQR4naj0atv4
         Oq2Irpx9xF9/UD3GrI2tt1dz9wjZPi74DlD8MeLlW9OOs2c88YVQS3BcSGeQatuNG8Vt
         sABPQhpK2CpQujeBsSEqmVuUbDE/ZAZgjD/nvt0xCY7IwFXsI2Cj7B+LaN93eLT3I5zy
         D/Q97H9+QUK33gvYm/pQpNfXOAktOXzUN6MH5ADE0bWShbowHot5lK4Rzax1TQk3pSzh
         q4DoEbaFAfVGFZ3LroVZRi+CzYbe6KkUxGMGteGOD1Z2XoRgeAPou/ic3FEAq8O9qbWK
         JTZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HOKshWbqQuwRhhDJ0LM9x746hXyd/I6CMyphyns8L2Xv1HrRkglkSXN2BMlj+6Np+c6HXkaVDgeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw2GbxtXZZhBA7OZce58+oM4qNVx3mUdxN5w5O+yMlkVhFUZsQ
	nPN0ikzyFf3hYwZjXICaCWVkMeIE7W3N/xInQ8F/Xx+9FjJyh0x0H8Lg
X-Gm-Gg: AeBDies0BnBqpNgAds0QO4XmWLi6lAPGeQG6qFTMn38DELhV63HUCEZVmwMHfwo+4hr
	KYHWIhGHJG4lYcTdI5hw6rmMv+JYPxzSOsSTYN50Y7ULGdPJ6wfHjJDWL12Hgpq/syob3fe8tpE
	gfrqVRXDYCuMsI8gNefPwLQp54O9Fz5jhmDuwgRfuN6xPMRZYqH/uqF6TH4cHogiavCySoC4YGn
	kirJddAgu9kqquXVlR9wCaA9abw85v7Rp709t4E0KzcYEXgMaGf2V/Bu4jpe+8bzZNtXj3G7WCE
	EwoQ7VDW+5syqfFGDCHxMv4QMx/klDJMLWQpGRdcruPA9U/1SEOUtoMMxlAE6VxOaGFeTBJc45i
	f20lHyyMxpmfA5w83F51m9MM7kVVolYcZ1m1wBrvtLH+mCHnOECKjAHFOhwn3YEV5byQbcWZ1C/
	Alm2OIb5coWYfz5qGdp3xFNk1/DJVQ98mSmrdtDNAl/gxyYYkRbjmolGkf7cyn+2hLC35UDIfq+
	+vMiXOGhA==
X-Received: by 2002:a17:907:97d4:b0:bad:5231:d5c with SMTP id a640c23a62f3a-bad52310d9fmr173197566b.47.1777025373429;
        Fri, 24 Apr 2026 03:09:33 -0700 (PDT)
Received: from f (cst-prg-93-232.cust.vodafone.cz. [46.135.93.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6771dfcf628sm1496915a12.24.2026.04.24.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 03:09:32 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:09:18 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>, 
	Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
Message-ID: <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412135434.3095416-2-jkoolstra@xs4all.nl>
X-Rspamd-Queue-Id: 0D72D45CCBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6166-lists,linux-api=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, Apr 12, 2026 at 03:54:33PM +0200, Jori Koolstra wrote:
> Currently there is no way to race-freely create and open a directory.
> For regular files we have open(O_CREAT) for creating a new file inode,
> and returning a pinning fd to it. The lack of such functionality for
> directories means that when populating a directory tree there's always
> a race involved: the inodes first need to be created, and then opened
> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> but in the time window between the creation and the opening they might
> be replaced by something else.
> 
> Addressing this race without proper APIs is possible (by immediately
> fstat()ing what was opened, to verify that it has the right inode type),
> but difficult to get right. Hence, mkdirat2() that creates a directory
> and returns an O_DIRECTORY fd is useful.
> 
> This feature idea (and description) is taken from the UAPI group:
> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
> 
> @@ -5276,6 +5294,10 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>  		if (IS_ERR(dentry))
>  			error = PTR_ERR(dentry);
>  	}
> +	if (open && !error && !is_delegated(&delegated_inode)) {
> +		const struct path new_path = { .mnt = path.mnt, .dentry = dentry };
> +		filp = dentry_open(&new_path, O_DIRECTORY, current_cred());
> +	}
>  	end_creating_path(&path, dentry);
>  	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
> 2.53.0
> 

Last time around I pointed out fd allocation being an issue.

The general problem is introduction of a failure point after mkdir
itself succeeds as there is no way to backpedal from it.

With the patch as proposed this remains a factor -- dentry_open itself
can fail due to inability to allocate a file obj, and even if that
succeeds there are several ways for do_dentry_open to error out.

For the patch to be viable some rototoiling is needed to make it so that
all the prep is done before issuing the mkdir. The only thing which can
legally happen after is installatin of the file obj in the fd table.

Now that I said it, the open handling is already buggy in that way.
do_open has the following:

	error = may_open(idmap, &nd->path, acc_mode, open_flag);
	if (!error && !(file->f_mode & FMODE_OPENED))
		error = vfs_open(&nd->path, file);
	if (!error)
		error = security_file_post_open(file, op->acc_mode);
	if (!error && do_truncate)
		error = handle_truncate(idmap, file);
	if (unlikely(error > 0)) {                                                                                
		WARN_ON(1);                                                                                       
		error = -EINVAL;                                                                                  
	}

Suppose O_CREAT was passed.

There is no attempt to recover from the LSM returning an error, in which
case the file is left on the fs. The only LSM even using the hook is
ima. Even if the user being able to create the file implies the LSM
check will pass anyway, the inode itself is not locked so root can sneak
in to chmod it and trigger a failure. Suppose that's not important.

Things proceed to handle_truncate:
	int error = get_write_access(inode);
	if (error)
		return error;

	error = security_file_truncate(filp);
	if (!error) {
		error = do_truncate(idmap, path->dentry, 0,
				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
				    filp);
	}

I'm going to ignore the LSM situation and do_truncate failure modes in this one.

AFAICS nothing prevents the same user from racing against file creation to
execve it, which starts with exe_file_deny_write_access. Should the
other thread win the race, get_write_access will fail and the WARN_ON
splat will be generated. That is definitely a problem.

