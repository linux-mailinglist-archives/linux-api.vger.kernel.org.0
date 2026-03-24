Return-Path: <linux-api+bounces-6036-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMSMA4l7wmnqdAQAu9opvQ
	(envelope-from <linux-api+bounces-6036-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2026 12:54:49 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D36AE307B1F
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2026 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7A0B3077638
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2026 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B03EF666;
	Tue, 24 Mar 2026 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YiRr9YK/"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F53D567C;
	Tue, 24 Mar 2026 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352731; cv=none; b=sIp//d8Ljo7C1OKJdROSX+hxxnG75C6/h51/goHWi66/C6QEVKsc3ZGVx9l3SYMQKsAVhTpXfSUhCZ+38Mrk0utXda90kEFpOA88dgwto3k1JmtqbiJ/YxEadfPiGjkBRkj8sShS0BXmejDEyIXXw82AXo5ebkxBJs+sFKy7Jd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352731; c=relaxed/simple;
	bh=jX9K5Qlsw2+8JcKDr7ZdGFTMXbl3yHVN3G0kWBInI2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq07tjChDu0hCnmEMb0So9UpEoio5vs+Vxx1H6HXVKvC2ZA3zSpfb+hOtNXxcmzag1CiuHnn2LotnocTiAtYIi8BzKdKKegS6xPITzYSe0YHmha/Dj9twiLRdbc/TJ28wk+gWbalGsSc0bsQqKyeVTBfr4FsqptaQDLirsDwXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YiRr9YK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DD8C19424;
	Tue, 24 Mar 2026 11:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774352731;
	bh=jX9K5Qlsw2+8JcKDr7ZdGFTMXbl3yHVN3G0kWBInI2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiRr9YK//eYw2iDlddt7wJge8uPj7jby/M6AT158a6asUFKu5bwzAK6uTvBZDhObx
	 GatsYKcKCyJnqdxQ5I+pyRkqdsoBPOfBH8wBHawSbHuKgn4susDEjUmyugfyjnHhLJ
	 isDywhM8qGYzM5yxvmrF+POFOCmJ26n6oqbgiqPs=
Date: Tue, 24 Mar 2026 12:45:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/9] kernel/api: add debugfs interface for kernel API
 specifications
Message-ID: <2026032442-step-blush-a0e5@gregkh>
References: <20260322121026.869758-1-sashal@kernel.org>
 <20260322121026.869758-4-sashal@kernel.org>
 <2026032309-jargon-stalling-28c2@gregkh>
 <acHTupVGxJR3gmFT@laps>
 <2026032411-paramount-lapdog-41e6@gregkh>
 <acJ2gnnA9MP1wO_Z@laps>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acJ2gnnA9MP1wO_Z@laps>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6036-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,linuxfoundation.org,arndb.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D36AE307B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 07:33:22AM -0400, Sasha Levin wrote:
> On Tue, Mar 24, 2026 at 09:20:01AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 23, 2026 at 07:58:50PM -0400, Sasha Levin wrote:
> > > > But this only works if the kabi stuff is built into the kernel image,
> > > > right?  This doesn't work if any of these abi sections are in a module
> > > > or am I missing that logic here?
> > > 
> > > That is correct, for now.
> > > 
> > > I'm only trying to tackle syscalls to begin with, and since no syscalls live in
> > > modules, we have no need for module support.
> > 
> > We used to support syscalls in modules, but thankfully that is now gone.
> > But, how will this work for stuff like usbfs ioctls?  That is a module,
> > and our uapi is, by far, in drivers through ioctl "hell" and that would
> > be great to be able to document through all of this.  Will that just not
> > be in the debugfs api?
> 
> It will. I see it working just like how BTF or trace events do it now.
> 
> When a module loads, find_module_sections() extracts the .kapi_specs section
> pointer and element count into new struct module fields. The COMING notifier
> then iterates those specs, registers each via the existing kapi_register_spec()
> dynamic registration path, and creates per-spec debugfs files under the
> existing /sys/kernel/debug/kapi/specs/ directory. The kapi_list_show() function
> is extended to also walk the dynamic_api_specs list (currently it only iterates
> the static __start_kapi_specs..__stop_kapi_specs range). On GOING, all specs
> owned by that module are removed from the list and their debugfs entries
> cleaned up via debugfs_remove().

Sounds good, I was worried about that static range and how that would be
"extended" or not.

greg k-h

