Return-Path: <linux-api+bounces-6030-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIUoHrAnwWmbRAQAu9opvQ
	(envelope-from <linux-api+bounces-6030-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 12:44:48 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520A2F1648
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 12:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 592B2300E584
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417139936F;
	Mon, 23 Mar 2026 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR/RCY7x"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F03947B9;
	Mon, 23 Mar 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266276; cv=none; b=IpOAyOs0W9RzNYX1HcrzPFnON1ch5BD/YxEXk2AVHN8fdfejjSscjpZf5jv8otE6cjhS+BX8orFr1EJIuscl355o5kchVtncRBWFqSOK8CuCPqJlVN3mJSYkmij5IPvCmkna4+cWF37IU7U7N9uV59Zw+nBRQiEUcQaN4KkSDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266276; c=relaxed/simple;
	bh=aXd296Lm46/RWsbI4I1OOM2FgVG5HdKEPdtKxCcKiSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaItbg3pNpaZhj1Z0GAnQIf0MosoEVsRYYRQX+8WbOtXNyXOVXAjpAbKGYADx0Igs73NAKhXzLBqAU9jSTLH2mArAPyUzO313pCnQYfjvcEoRs1MfDMIn3aJQD8trMHT3eF40Vo6gMaGAIHTKWIDM5Nexwm022YqzYizO+o4SfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gR/RCY7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622CAC4CEF7;
	Mon, 23 Mar 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774266276;
	bh=aXd296Lm46/RWsbI4I1OOM2FgVG5HdKEPdtKxCcKiSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gR/RCY7xEISChh9Lrf9qGuhPEZS19LykvA5um6hJZDCEVVMpMFmEesD49v4VS0VeX
	 7tvtxyMDQ8xUKY4iIhm3sU/C9WMRUdj6Z81Mw6hUi1GQnRCuXsZFys+7kWnJiM8LcH
	 8qIODBP67hQ9u9z4blHsBR/iyNhx3ikj0My0HbCKCwAfCv1CzXTou3L+pTZAo5icZX
	 O7F1SyOoy3ailgv1X6DwqsvZtE5mFHC/I3tpfFNVdXE7iSSWu4p62HgxDdHbQH+JxZ
	 xHniVseYGTA81Swnq7Ya3s5cLs7Yq1ml1dSxfQYULHCaMrleKub1aY5HyQ6V3LTinA
	 /L+uZAmg1tcww==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: fix architecture-specific compat_ftruncate64 implementations
Date: Mon, 23 Mar 2026 12:44:08 +0100
Message-ID: <20260323-pocht-abberufen-825ffe02281f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323070205.2939118-1-hch@lst.de>
References: <20260323070205.2939118-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=brauner@kernel.org; h=from:subject:message-id; bh=aXd296Lm46/RWsbI4I1OOM2FgVG5HdKEPdtKxCcKiSg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQeVJ/Ny96b4PNJrzr+9NOiA/8+bLx4YW3lMTVfacWzS 0yOhLLad5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwDmGf1plEULnTrzd+kq7 uMavcddW/zt2IduMvmY9VrKaK9Qs58Lw3/Gk5+XnL/zeeZz4yxfF98j+tsyNy3aT8znSj9yckRz wkh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6030-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1520A2F1648
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 08:01:43 +0100, Christoph Hellwig wrote:
> this series fixes a really old bug found by code inspection, where the
> architecture-specific 32-bit compat ftruncate64 implementations enforce
> the non-LFS file size limit unless opened with O_LARGEFILE.
> 
> Diffstat:
>  arch/arm64/kernel/sys32.c       |    2 +-
>  arch/mips/kernel/linux32.c      |    2 +-
>  arch/parisc/kernel/sys_parisc.c |    4 ++--
>  arch/powerpc/kernel/sys_ppc32.c |    2 +-
>  arch/sparc/kernel/sys_sparc32.c |    2 +-
>  arch/x86/kernel/sys_ia32.c      |    3 ++-
>  fs/internal.h                   |    3 +--
>  fs/open.c                       |   40 +++++++++++++++++++---------------------
>  include/linux/syscalls.h        |   16 +++-------------
>  io_uring/truncate.c             |    2 +-
>  10 files changed, 32 insertions(+), 44 deletions(-)
> 
> [...]

VFS CI: https://github.com/linux-fsdevel/vfs/actions/runs/23425735066

  x86_64 (gcc, debian, ovl-fstests)  pass
  x86_64 (gcc, debian, selftests)    pass
  x86_64 (gcc, debian, xfstests)     pass
  x86_64 (gcc, fedora, ovl-fstests)  pass
  x86_64 (gcc, fedora, selftests)    pass
  x86_64 (gcc, fedora, xfstests)     pass

---

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/3] fs: fix archiecture-specific compat_ftruncate64
      https://git.kernel.org/vfs/vfs/c/e43dce8a0bc0
[2/3] fs: pass on FTRUNCATE_* flags to do_truncate
      https://git.kernel.org/vfs/vfs/c/0924f6b80d4a
[3/3] fs: remove do_sys_truncate
      https://git.kernel.org/vfs/vfs/c/e8767a3134ca

