Return-Path: <linux-api+bounces-4148-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206FAFEF13
	for <lists+linux-api@lfdr.de>; Wed,  9 Jul 2025 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92B64A57BA
	for <lists+linux-api@lfdr.de>; Wed,  9 Jul 2025 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C8220F5B;
	Wed,  9 Jul 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ALzddMnZ"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484E21B8F8
	for <linux-api@vger.kernel.org>; Wed,  9 Jul 2025 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079715; cv=none; b=UXHoXkrCvV2Wck5bjFOywV9X56AtYN03Ai+zeCZYAp8aLyxblicRw2AzvzMMMyuBr3773kRZKqwKmLwlPcqz6F4shuwtmiNg5LLyDY/lyaX3Hl3ShEWUckq/61eW2l3Mi+bg3033Ison8wnWtPRdOAiB0W9cBRqwVNBGnPoFC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079715; c=relaxed/simple;
	bh=wRmR9hNZzz7aXnp2PmuXRHHVYJ7nrQGQYHH/VK1KGAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpmTgXDfNZAcVg+qCT4WQrKVbobz2tvuqA+Zw/YI3+mRpu1gVM0atnrgFkVkjhvmaiYbkP6rgVNne/fSVMw6+EgQbuwXocVs5hFhDqI9S9EnU2dhOOWZN6p7MtawdvCCxPDUV7GrRBh9nMwhvBLim+yLGb27Cv2EJIhvye7TSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ALzddMnZ; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752079706; bh=kc36E2wI4bhwWTlYhfYkcEYRMP1zv/4SkOL/rVZnv6o=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ALzddMnZhWw2MIif5phz8ng9yIsyHTKbMwEg3MgQpZOrTplxU6XaXfZrHwBi2B02I08pxWW9JXpj3RuZL5HIVibYMOtygMfheWchqy2vJ92bESmhdGHbXUtiHQVI3RjXxt8rGeVq+Xhxx/rVab22u0J1ynCNbu1bGBcRsZTJ0wNQVLYQ+5qEsNGYUohQt0tDYeA5hnBYtnRqm4cAbqG1VevQFRiy7mnXV9ZkvU9J8psWNgUDa99iPb2rJOSD/+oLEh87q18uYgthjFK9aMGn4qjLlprq+Gyo5p5VSUGyLdO6YssSZamK/O9YSTQgx5wNOVUC10RsuL2bSS/OE1RubQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752079706; bh=/mimeaU6GDhZfsBWZ6ZZR/0Q2Yiel8Egxhz3jIsQSoW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=S+d+xLE6zPZBmQT9qohqGXIifGui7v/TKaqMrobiq9b7HvlZEr9K777tIbdErFunYk+Y2cj3kLieHEqVNgAfhLqFA93r98KhFnmB2Y4sGyOn/zfhiuQUTEYIlbjzPLKAQifhtZPJT5gLVbqTVTW6dt8VEJEA3iSnoVT5J+v2+3ONnGe0MH2lKFwlIrywZYeSzjC+YLiDxV9UzujPFeaA7IAVeLjOZhoH728bBmlidS5E/UemNmti1rZwhWAJ7frkBHTXNdk+kloEBeLA5dMBi3z3bBc3SoVp4AOa+uYu/MbWz/DV1d6WPreIXPuaRNk9w1Pd79/H/CSIp0Z6mRnkRA==
X-YMail-OSG: oOjeceIVM1lDOKc2hTjru7tHo9CzfFuHeUnjAvTkZY7lzXBXz7k8nP8XqPkQ2yM
 BffS_2b.NZl77j_O6.aSgk.49KcS1YEzfRQMY0p1KEpjiXqVpGjEoBvrRYV3dZkd1AXVgrUe9mGo
 P00QSszv1gCX6qDeyF9KBc3a4WM09qLeq1OPIeZovnQbfmhpnshzuXUtJNjO4mdKKDvhotPNzLwW
 _xrwycoKeLXUZ.LRQpVLhBeV3wKM_Wtai.CpJJXiTzg_G_iA9HomCma8_iyVG07FfpDOz1KmRuVr
 Luk.AdwkS1E5ggZZkqhcLyf0ljM2q1jnqgHCqxsrWwtijV5JibS7Lgzifx1OTK_mi46qZ9yFqHeU
 JqDMaXPTeaI4SiMyl9vdM_LPPigfww6GRPMljxl_aJIxiCp8819C.T5DQ.ptJ.BLOqckR4rMonpc
 X_4QFWtryCZsab.5x_U2ub34RiVt09dPm0BE7Ozu5GAV1Fx.0l1QKExh.Ffxy0sVcch77NSpUqBf
 Pz_j4pwXhJsz0F6PnFPReAIC1jdX2SHMD0vati581YmqnI4y6KyBexSxFqQ9t.cyfPh2.aX22gVy
 P2tth18W.eIV_6WzD2uIo5HqxunmH1aPorIt4DFG6lroHEETOMVEO56qKeZOWYBqbD2MrRKoCxxm
 _6VIxHUdA6Z1Qj7ZrMl.CGA7A4LGoApPIzAssmGtScHf1xZmclTlEnMjCWESB4Ekqzci0GpMgqXa
 D_3Ol24JNMesLMedscOzNumP_YHdi6sY8Ls7k6cMVdeCyLgpj2A1RheLLhHHGjXd1FLrbBLOMIQ5
 LRWZCGKUPsW4MQAeXdFMsn7PAv2ZgeP9ueksDKkoVsuqjx0uXaU4AlBXboRZ4ro2zZtsP.aP8i7t
 6t.QKYLTMQsQ2h5IzV5R2wdxx8aVhlWrufi8g.r0qLm8wNDT1mJ9TuUveT59gV0ctVBjZD7kDj5F
 Elw63n0ECmIprDQBqe_xPnL4SfLki3kkcqIXQBF5ShfsODzCPvOX7nYgObFL0j2AvcIciyfnKQai
 gSf6xkEJ_dQ32eVUfWkWLY7_ja.vZu1kGYQgBF2jgEVOfEk5ihhmpcwVKkuyOYKVn.XP6DpqXEWG
 FRHdxQ.SJ1fevh07Sxu8D.sFaSuT54th1fZ8OcFpdJmTuReZFrJew6rx5cDjItAFuNJAGFpTIdM.
 Yk42VATl84vbQ7tWgcxLWUxBKWRXHVRJJLr1uO_cTFsB0bl3BiKQfT0zxdkAUup1W0CmnxA7bIGR
 jG8MjOKiITW.1x5qJDDKlj.879lEjmwUvFI2RZBLS6fYuIn.GWxQOY3x7s6rRk6ACEpymN1PJb3b
 2okO.BnZkqof93_1C6G.QfHtzK3f144bO9MeNE6LugnbB3Cfm_921SqVIb0a6170m0AABOkDkgCX
 WO5Lqy8rHyKqWuGoF0CCI7KX4I0IYBVPw9MfOHcxZIbRVJC4Ddyrav6jegXjPNQY2UORgxvNYBGU
 WgPCA4uRmCtBO3pvkSK9nHdFFBqsjRLx3TAl0HFFcP7tlttuBp7NyIEx_gkMJxwbKb4iKqAsgQDh
 tJdqb_7m9NKa0F7j2iuhKppL0LtPLtPTN7mperGNvjaUlNl4FFhdgM7Bk0pQ2AEIjEf_Y.utrnlW
 4ujR673upy4cONQbOWdQcYl.Uwnv4DcNE9v153OjfUE704NLiX0FVu_ciDJELWFIDp.R3g0N6scu
 n6TsN6RE0VlikbbhY3d0EIvf6VgCwf12V5MyVs66Na1dvjmSicHFSSvFhvUsYkoQ.junpPN22llQ
 eSObtvTNXZh6wYxeAi30PaEBfxs7swQ_oh45oRti9xkJE_QGbd3md11PoSy1nnlctgW45FD2N765
 fLwZZuF9fHSQQZA9MTkF39kLIB_fViEiaCfxw.lrUts3H9.WIW7VhNhrwYBFmCOjW5o2gJJJv57i
 ZoKpQw7so85w95vC.ONQfaSlH3WXX5mI86ngm4Uys868kB29IvDe2kgWvyPDRwipzpCIPTLODeXn
 0iKb90XcijGK.w.vmfnP5T63D6Czd4D6OSLUu.rbPjY2kO5SIBigO2KwfSIfuUwbxt_3BLJh0ybJ
 1eKXTXsA16.jpR0SgJ9LEvnv6zzamxuAQDyKoTM6NuOQkrPn5.FrJP6yJVhEqQSJx7eJQjH_M.6Z
 gf4BIgExu1fqIJr8w3BtejYxu613S.FKVHHqMwal9uvstZ9E_gtGeClLvuKgafIy7YKD.DmyNID7
 Th8ym1DxwiM4ob0qRP2Dpj6H3vUBDVD3wVeLVRrcHltDcXU_y2b3NlI0zG8EJi.82hR44rzFOm1a
 7fRO9ucClRTz3a3j5rbI-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 95f83a92-85ed-4d51-9d2f-7281f23145f7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Jul 2025 16:48:26 +0000
Received: by hermes--production-gq1-74d64bb7d7-s6s6l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 91ff29a2e51ab3f0eda0900cc0979479;
          Wed, 09 Jul 2025 16:48:24 +0000 (UTC)
Message-ID: <5ae541ce-613f-47c0-8a23-1ec9a0b346cf@schaufler-ca.com>
Date: Wed, 9 Jul 2025 09:48:21 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] lsm: introduce lsm_config_self_policy() and
 lsm_config_system_policy() syscalls
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mic@digikod.net, kees@kernel.org,
 stephen.smalley.work@gmail.com, takedakn@nttdata.co.jp,
 penguin-kernel@I-love.SAKURA.ne.jp, song@kernel.org, rdunlap@infradead.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250709080220.110947-1-maxime.belair@canonical.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250709080220.110947-1-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24099 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/9/2025 1:00 AM, Maxime Bélair wrote:
> This patchset introduces two new syscalls: lsm_config_self_policy(),
> lsm_config_system_policy() and the associated Linux Security Module hooks
> security_lsm_config_*_policy(), providing a unified interface for loading
> and managing LSM policies. These syscalls complement the existing per‑LSM
> pseudo‑filesystem mechanism and work even when those filesystems are not
> mounted or available.
>
> With these new syscalls, users and administrators may lock down access to
> the pseudo‑filesystem yet still manage LSM policies. Two tightly-scoped
> entry points then replace the many file operations exposed by those
> filesystems, significantly reducing the attack surface. This is
> particularly useful in containers or processes already confined by
> Landlock, where these pseudo‑filesystems are typically unavailable.
>
> Because they provide a logical and unified interface, these syscalls are
> simpler to use than several heterogeneous pseudo‑filesystems and avoid
> edge cases such as partially loaded policies. They also eliminates VFS
> overhead, yielding performance gains notably when many policies are
> loaded, for instance at boot time.
>
> This initial implementation is intentionally minimal to limit the scope
> of changes. Currently, only policy loading is supported, and only
> AppArmor registers this LSM hook. However, any LSM can adopt this
> interface, and future patches could extend this syscall to support more
> operations, such as replacing, removing, or querying loaded policies.

It would help me be more confident in the interface if you also included
hooks for SELinux and Smack. The API needs to be general enough to support
SELinux's atomic policy load, Smack's atomic and incremental load options,
and Smack's self rule loads. I really don't want to have to implement
lsm_config_self_policy2() when I decide to us it for Smack.

>
> Landlock already provides three Landlock‑specific syscalls (e.g.
> landlock_add_rule()) to restrict ambient rights for sets of processes
> without touching any pseudo-filesystem. lsm_config_*_policy() generalizes
> that approach to the entire LSM layer, so any module can choose to
> support either or both of these syscalls, and expose its policy
> operations through a uniform interface and reap the advantages outlined
> above.
>
> This patchset is available at [1], a minimal user space example
> showing how to use lsm_config_system_policy with AppArmor is at [2] and a
> performance benchmark of both syscalls is available at [3].
>
> [1] https://github.com/emixam16/linux/tree/lsm_syscall
> [2] https://gitlab.com/emixam16/apparmor/tree/lsm_syscall
> [3] https://gitlab.com/-/snippets/4864908
>
> ---
> Changes in v5
>  - Improve syscall input verification
>  - Do not export security_lsm_config_*_policy symbols
>
> Changes in v4
>  - Make the syscall's maximum buffer size defined per module
>  - Fix a memory leak
>
> Changes in v3
>  - Fix typos
>
> Changes in v2
>  - Split lsm_manage_policy() into two distinct syscalls:
>    lsm_config_self_policy() and lsm_config_system_policy()
>  - The LSM hook now calls only the appropriate LSM (and not all LSMs)
>  - Add a configuration variable to limit the buffer size of these
>    syscalls
>  - AppArmor now allows stacking policies through lsm_config_self_policy()
>    and loading policies in any namespace through
>    lsm_config_system_policy()
> ---
>
> Maxime Bélair (3):
>   Wire up lsm_config_self_policy and lsm_config_system_policy syscalls
>   lsm: introduce security_lsm_config_*_policy hooks
>   AppArmor: add support for lsm_config_self_policy and
>     lsm_config_system_policy
>
>  arch/alpha/kernel/syscalls/syscall.tbl        |  2 +
>  arch/arm/tools/syscall.tbl                    |  2 +
>  arch/m68k/kernel/syscalls/syscall.tbl         |  2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl   |  2 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl     |  2 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl     |  2 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl     |  2 +
>  arch/parisc/kernel/syscalls/syscall.tbl       |  2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl      |  2 +
>  arch/s390/kernel/syscalls/syscall.tbl         |  2 +
>  arch/sh/kernel/syscalls/syscall.tbl           |  2 +
>  arch/sparc/kernel/syscalls/syscall.tbl        |  2 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |  2 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |  2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl       |  2 +
>  include/linux/lsm_hook_defs.h                 |  4 +
>  include/linux/security.h                      | 20 +++++
>  include/linux/syscalls.h                      |  5 ++
>  include/uapi/asm-generic/unistd.h             |  6 +-
>  include/uapi/linux/lsm.h                      |  8 ++
>  kernel/sys_ni.c                               |  2 +
>  security/apparmor/apparmorfs.c                | 31 +++++++
>  security/apparmor/include/apparmor.h          |  4 +
>  security/apparmor/include/apparmorfs.h        |  3 +
>  security/apparmor/lsm.c                       | 84 +++++++++++++++++++
>  security/lsm_syscalls.c                       | 25 ++++++
>  security/security.c                           | 60 +++++++++++++
>  tools/include/uapi/asm-generic/unistd.h       |  6 +-
>  .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
>  29 files changed, 288 insertions(+), 2 deletions(-)
>
>
> base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b

