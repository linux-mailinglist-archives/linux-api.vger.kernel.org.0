Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A9159D00
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 00:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgBKXNq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 18:13:46 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:34052
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727916AbgBKXNq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 18:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581462824; bh=4CqsCWSj75Z56jDcVXICXqJheNKDOCZND7DXRw7Kr18=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=F5lHcnfjLSjbFv9sifAQnp3lodAMxv/v+ghCk447qISQMv0nUj3lDt1cCGLkulcztdNi3HHLOcCSHyxfV6AeNF5x2ub1OmxYcDL3Z7ekDb9YYP2SclTV8D1Xa4wfTNTTivBLCYHZ79voHHeU8+aMyH/Z8FlEJwcomOzZwMU160N2AElnwIULN2RES/2Os7HFHl/O856ke3HSyETKoXo77X16MkvcOfx/ZeEwddTYy5KjehDHklqb2UryVXo9ASYbbwjmBi1aAdSvHco7nDV4x8JD786n6Q+mfCjBfyWZLaSo2L5Qk4YqNMr2tpLY6h1cNVBXNr23wvAIhOKdnMY01Q==
X-YMail-OSG: r9SLAdMVM1miPnxkcMcOvCKsqByVmK1roS_EFPENuZXcluyYEd81Y.vN_JSKc.Z
 A9Atc9jL9jkunRJQVtLK1Ed2jzByquJO2Q0NjY4kB9XAAKuy3a5BOpnuEi0BAbRwyDjBv.1S5qsR
 xrobZqRn_mvJh_EIskaeh_gfNJDQy3fJi1oN0WZWA2ybszsXncqcxxjoNymj9aaXgBpyqq8FXyBM
 9_qvJzaKe.Njil_Nec.MRkCYr16jBRqlvxSFdmJI2MpudnKQeUwkZaA7eyB6Atp2JC0L_DLmpz0Q
 DlpB_m9md59qDK1JrJKfkD8Zl5D6.2heHRcY3Vialh6aYydGl8q2IrJfCgmniJ58yESo1Vn.jvFs
 Ikfzqw7lBSSGJpZyNbxXyVhtsejkRaXynqrKByfeqPTLJItepRgl_gmkh9qnjZ7w6gukG2sgynsh
 oXUdw961ugBBa8dTzJPS27wrdkYoZFenOLGZrTqzxcVIEvoWknF3pP_dwriI7QPPU6gTOQt0XJVT
 c75RDt_.8_END3o10L7P2XwH6.jH0jSfzulms0IB2eePFLFs7y.R0lAYImPqQiqZhS_EQCRiIRPw
 dC2wUEj.EzHIgxLcrclQieVTq8SsTsDB9PQ6QrV5kNEeVstmm.u5W8S_b4pSm0l4y_t5KjGIoHlp
 cYzToJHPnLoc.9y6pdzHRglaUj3j2DhrqXVC16rCKNubpXPBYOTS4WCtM7K3jG1dAyxwr_hRAudV
 .u0SOXgLzZ.PXL.WemAntMVWCzNbI5su8wotZF1aljn_icOTM2.awtof7YuySI._NRYg2SwneI.C
 EEXYy0GzmahutLP7.vMPh2ndZfkVZS.uc.0Lo0N5ZyAcfgPRECpXVX7euyNJ6ti2xT86WqYge.ov
 EJvPWl1qQewOXyyQA8.10dxoQCf77r581WThfkoZNxmZH3LJ5oBO.0wf8aAWU44Jfh7__4yqkdqW
 .MDjUffpYukVFP4M5x9D14KktiVB2BpvuJPiIIENs7LATeppdB0FoXD3WVUBVrrxPcj0dKexxd91
 oVjDngAW8oyKmnYAOoCuzGnh.4cyvhVABm2lCjcns8DSdimRPKxEb167mLRwNLMbGLY30qigB18A
 AQYy6FkddjXVs3.975Y5VLp0ayRvRmtxSViI0jfLEGq8yDZTvJyvWI_SA6tt6z86Vyof7X_ea8Yt
 G_B4YfMXzDdcCMFHqDhJigGUBVMi.f9QqWXhd9IQcEs1aQANHINDHqHZ9lITDD0NL2xuFXJZ6uRe
 ywt3kPHIKLdQxH8iCitdqKOgdammZWdO9EnxqeybhTeeoIJDucugzfDDr75jA5eYSvd5hPEx8FNg
 yxqj2oRpe.ny7qjz2MYQIMP0yyvh3KJQnU4wLdKim_N.6VV1T3GL8mIDSZGNeZMZtXiZ8_z4pHYh
 30.Asv4mJ4BKACWmqWfjO2Z6UinhfgwxV4Z804mLdoncHTt993pBsElosBk4HGedZqd3L
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Feb 2020 23:13:44 +0000
Received: by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 713b4cd5bc6631751294315c0d8be81a;
          Tue, 11 Feb 2020 23:13:40 +0000 (UTC)
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        nosh@google.com, nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
References: <20200211225547.235083-1-dancol@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9ae20f6e-c5c0-4fd7-5b61-77218d19480b@schaufler-ca.com>
Date:   Tue, 11 Feb 2020 15:13:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/11/2020 2:55 PM, Daniel Colascione wrote:
> Userfaultfd in unprivileged contexts could be potentially very
> useful. We'd like to harden userfaultfd to make such unprivileged use
> less risky. This patch series allows SELinux to manage userfaultfd
> file descriptors and allows administrators to limit userfaultfd to
> servicing user-mode faults, increasing the difficulty of using
> userfaultfd in exploit chains invoking delaying kernel faults.
>
> A new anon_inodes interface allows callers to opt into SELinux
> management of anonymous file objects. In this mode, anon_inodes
> creates new ephemeral inodes for anonymous file objects instead of
> reusing a singleton dummy inode. A new LSM hook gives security modules
> an opportunity to configure and veto these ephemeral inodes.
>
> Existing anon_inodes users must opt into the new functionality.
>
> Daniel Colascione (6):
>   Add a new flags-accepting interface for anonymous inodes
>   Add a concept of a "secure" anonymous file
>   Teach SELinux about a new userfaultfd class
>   Wire UFFD up to SELinux
>   Let userfaultfd opt out of handling kernel-mode faults
>   Add a new sysctl for limiting userfaultfd to user mode faults

This must be posted to the linux Security Module list
<linux-security-module@vger.kernel.org>

>
>  Documentation/admin-guide/sysctl/vm.rst | 13 ++++
>  fs/anon_inodes.c                        | 89 +++++++++++++++++--------
>  fs/userfaultfd.c                        | 29 ++++++--
>  include/linux/anon_inodes.h             | 27 ++++++--
>  include/linux/lsm_hooks.h               |  8 +++
>  include/linux/security.h                |  2 +
>  include/linux/userfaultfd_k.h           |  3 +
>  include/uapi/linux/userfaultfd.h        |  9 +++
>  kernel/sysctl.c                         |  9 +++
>  security/security.c                     |  8 +++
>  security/selinux/hooks.c                | 68 +++++++++++++++++++
>  security/selinux/include/classmap.h     |  2 +
>  12 files changed, 229 insertions(+), 38 deletions(-)
>
