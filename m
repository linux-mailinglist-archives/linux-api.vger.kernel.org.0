Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF570E096
	for <lists+linux-api@lfdr.de>; Tue, 23 May 2023 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjEWPdQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 May 2023 11:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbjEWPdP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 May 2023 11:33:15 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B98E49
        for <linux-api@vger.kernel.org>; Tue, 23 May 2023 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684855967; bh=1f3aHwhNdjZ75ghTtX+iCA0FZ0Vt2Uea6ELbiy8gdsE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=n2Zz24lvNQrSoOZxxktVjlaaz6aKj8lTwiCpBbKAzmZO4f39Kl5LPpCxHIGGM/LFPw9iiiwvPHmDlJriFWG2ZROONXJBgLKiQ3bhWHraKnL4I/QViiXsxpL7iwxLAx8Q6nnZOiJmW4Tsk95HUBOGQfAqjyNs/xRJjaDRvzEFWmdKR6HZnO4Orox/0QD4DNBKcrGfvnuDRiPkIR2bWw8E2ld5K6OYMqbJcOibYmO0FZDw1hKmEBcs/2hzztpXDl9M9iKyn0AJA6K8DED4MRYE7leIanBxs6BtAuwByZyTXf8XYhquhFao7cbMku45UlOA/H0tYflpm8tLidctGc5Wow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684855967; bh=7NTr6pbjvTBr6DsbfBG4+EtWndeqiUDPrk6Ae/CsNG5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qDE7a60xqob7KvSVk9IN9bfuFUePdgAfib2PLNIz7kyRg2ruoll8X/FbZ58mUvgBspPgvJRyLx4u3MAU7LVg/SyraHlrGOCSSU++qbDCyGomqqbTIeyu8PIgemh+QSL9y4BU6hR9PqSVjsKpePjlkikX9DRl8h8eHiPbp/ZlQet9PHzFNTm/tf/cgt78eMSr0FEEH8DWKsO1jG+sX7o8MNVurCgmoMMhFe3r2P4ozQzPB8YZfZN0uWALMX3Il15oELF5Ygjw900pI+6mQ27x1aetNP5mSm6MkLnKvPq4AHCvW44mX9IDMFryHKDXXj8oKXDTeLps1UOOyos90IjHZA==
X-YMail-OSG: nc_xqasVM1m3c_epD7ZR3_zZbIAbeAsVDPJ15V1K.anln.cmbM3_W5.8GAlpyTY
 zUaVpFCxxi2wOANHuAk.J2QRiI9USXi9V.xCP0ipySVchZk2LcFNqQqCKwVxrJohacltDCgu_UN1
 UirY8K6ETiJhyer52qEv1aQa1suv.1HFHqCEhnZ8r1JDfotRPRpM9_1goaszxksNenK62HY4SbdT
 kSwdFRQ6GwzpTth_qXNOf_IklcfsMCSz98vK0Zc_WuYz39L4azGh4gzMRywWCScdj4sPTdSAEf2W
 JGsXNK5bNTt13sz0BzTsWWn_pq3kcwQpQXQQcPAyO6hoxrNAAHzT8.3ILHCCyVCgCUZoh.pUlD0Y
 bjb3erOuM9u.grYf6PCQtMWa.1YS1Xr.AP_wAtORycluFkJs9wigA0SMPde.HXR9XSNDuNdoMrn0
 LuppJPigkHm5X6kz68lpTcbhw4eWKZs8fEXlJkBuLmuE9hVSCKfgfbIpLsZ4x6J8.tptG.9vpWQS
 sNwHBxj7LOcdF.avOmz7xrsv0raS6V.pSvgvoauRw9ESavIN0pyFCYltBosGcI4qXHzAJ_tDja9l
 QiTk7_2bkgwIile0W3i_CBWPGtIK92PTwek1sXGVB0NUPgEcUvuj.Pi3RRSXIhb4tdI1087XzciK
 QQR1oerO.oUqVTD5HzxOQmWFTWwKOJANBN6N2rlYcYGTdK2GpAsQe1gmnZpxgqj5sP5Y55p3Sbip
 3.9Dhy6WpFqvjsvRbM626Cs7hGPuWVpb72axpR4d1zsixCd0eEwwuf7QSpOcnje6gT5xhwxr9A13
 t7XU0X2aIcIdrLFf0VqXQ4W6To26gMp0tF8UXR8IYZXOiOy9aJpX0Aif7qi4GAJ3LWybF2RKdLar
 wg4BCK3Vda0h0tTCrgWADE0IUw1rkxBq37heMxqU9i_6rkIdR05HUryEvUAp3UXxupYaZMlJJkMi
 Mud89arQC4fTnYwDBDMaHOPn7jGsUiSA3yj7QrZ9i35udYGCa6WPS35EpI26oNLw.SQryxMfnZt1
 0SD3Pmaa9X5oBgpHQNAAfn0d5EB1vaf5K7W_7ky5f5qEeDC9RZa_QkohUb3j2q4L4z8QIXzTuL0r
 AUAdwBNKe4ZLskZzxVdKjrdsrJNjBYQJVHDNiSS_8Nrpp59U02AbduJKCtIFDRaoH2xehpGj8dkY
 5Nk79HAZbZArUt90biDCBHgQIg0jKI6YN1n4nbFTPaiTTL7KW52u4W7sCtNLoHIaqW0GdaXcJEoq
 v6ZE10p6ye.lZ2FDHNFWucvA.x.RMf0PxjJYpp8eknfyOWuC4NFERyu4VddEuTDLmgJr4yJZRpz_
 Gdcv.DRUbZ7OfjnJuk3Ib5ZPGXLfdGj1huLLp_pekv3q81IiYQuFf03_tTMMjWJRyBbEECcqJX02
 SmyjrNlyD5F2Sg2RAz7NbgKGyG8WSjiZvCtD89K1pvJOi2m8sNhtZeIqDspNDFncSepE0s5DzjJ6
 n_CIIlHnl9jlwdNWsgXZqvm5aMciS2vcqdzBBjIMILRBB9t4SSr0Sr0IJEVDYa.ksib52cI6ZSGD
 WnsRyAsPYW0XGKFZCawo4t50s6fvgq.wpZ_YnsqqQx0U.4LMs9suQyHS_FvI2fqSAlmO9kczeHI7
 GIiTUTxPgS9RsQ8vDu9n4FMFFgRKuUXzrgS07_IzMMW73ekU04os__Untqn4gcVi_U.dUvy8D.X4
 E6bL5HlYhw6pnCm2qOxPaR3AG8zbRX4T_lLSIASgZ84tGdmE.X2xQ.lCUw.tKyiR1DzvIjnpY8OP
 uLcWrKLD5jVDH65RUD_1vTTX3rx8ySpM3QCBuJbvf.RhXtuu0HM_b4RI63zBZayfq4tJU5onKslO
 YgIfvbo_yR2luFDifdUDw18Y6KP9hPnLNlNeqbFEGYoqAaMSU5ZXrYoPF2K2_d85uADHaO4EIwV2
 hnsAXXBG28ITZna5kg60v_Dgc9zXOygibqCpvQs2vdrYdKAKzAnh.ey6WVSoqIBc3VH5osN0CRcq
 3dn_B_6HXPbgMcy0m9qsMkTisRF09K9AHGOXCUwpEWquWjOarzRzJbzBG2LDDwVsqy0uN2nNaRp_
 jPJ3iFIN8PTiWNO3aFNFAtqO9ZaEcRCHYfQN2yd1_hiZGVgXdaiQgltE3Hlra5yeu.GNmf_dn.24
 xNkd254qeBin33ys2ShSyyWpoj4C8Y4koRNU70SDcufj6A7n_8ck7IYapGKeI2BS.3lSjsTVJ6xw
 h34sa4XWBq6p7yJWcjYYj52MRDxyz7YwBGtVVNJf1..yI6bJ8xbtBgdl7FZLtgn1ff5rgPyK3VQu
 cqYOe5F0loaUlwBs-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a6154ef0-3d33-4756-a144-8c7286e799cd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 23 May 2023 15:32:47 +0000
Received: by hermes--production-gq1-6db989bfb-4sk72 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 01446d56d8ca61a461636b84143f2f0b;
          Tue, 23 May 2023 15:32:42 +0000 (UTC)
Message-ID: <7b8688f5-20bc-8130-2341-ff56bb365d5a@schaufler-ca.com>
Date:   Tue, 23 May 2023 08:32:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc:     Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org>
 <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 5/22/2023 11:13 PM, Jeff Xu wrote:
> On Mon, May 22, 2023 at 12:56 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, May 18, 2023 at 5:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
>>>> Adds a new getprocattr hook function to the Landlock LSM, which tracks
>>>> the landlocked state of the process. This is invoked when user-space
>>>> reads /proc/[pid]/attr/domain
>>> Please don't add a Landlock specific entry directly in the attr/
>>> directory. Add it only to attr/landlock.
>>>
>>> Also be aware that the LSM maintainer (Paul Moore) wants to move
>>> away from the /proc/.../attr interfaces in favor of a new system call,
>>> which is in review.
>> What Casey said above.
>>
>> There is still some uncertainty around timing, and if we're perfectly
>> honest, acceptance of the new syscalls at the Linus level, but yes, I
>> would very much like to see the LSM infrastructure move away from
>> procfs and towards a syscall API.  Part of the reasoning is that the
>> current procfs API is ill-suited to handle the multiple, stacked LSMs
>> and the other part being the complexity of procfs in a namespaced
>> system.  If the syscall API is ultimately rejected, we will need to
>> revisit the idea of a procfs API, but even then I think we'll need to
>> make some changes to the current approach.
>>
>> As I believe we are in the latter stages of review for the syscall
>> API, perhaps you could take a look and ensure that the current
>> proposed API works for what you are envisioning with Landlock?
>>
> Which review/patch to look for the proposed API ?

https://lore.kernel.org/lkml/20230428203417.159874-3-casey@schaufler-ca.com/T/


> I guess ChromeOS will need to backport to 5.10 when the proposal is accepted.
>
> Thanks
> -Jeff
>
>
>> --
>> paul-moore.com
