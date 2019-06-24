Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3713C51F38
	for <lists+linux-api@lfdr.de>; Tue, 25 Jun 2019 01:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfFXXrg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 19:47:36 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:42522
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728370AbfFXXrg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 19:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561420054; bh=uWu1XqMlR8Wd+/WAHcLTn592/8LDckPRE3Zxxo4/TqU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=EL2ndxaZ9ptXNdKnzdi9EcMi9gbhH7oNQdksiqysOQxE/3v1kN2/tJPEFkMop3Dy0CDDb9DkanIkvQuPLpcMW7fs7l1LVZVgMYODkvG4psQU6CBiS21GMhmCOzZOtz4c290TF+/BW+0bmKrKj3LvaIQ7Hx8pnsYmALftTVDuK0DTpD+0U5YcTlF4d/Q4qFpVbD71ztAYv7azAZ5iHegQGrOpNfN+wfjlmNbG0BCr+NpYl9B3glKBFQAVNh9YAdlIcKr2Q7NqSZeHMyJi7KgChPvSiPidUmd6AOx1pfyL6dK6OebssQ9EOVyk+HncvrKaZAyavxl5WEHzHjP1g2lUcQ==
X-YMail-OSG: TvPHr2AVM1mklvawGVPUHVJ5fb5x40W_XyTZP8vL4IIxtjN5hozZL9pkVJ7mPvG
 eILLEabBOBL2LdrtQvOTqfn55Z_qofJdswxzUfp.iKxMsyxboD7jdL6ZKJiBH3GlpRTQxm.j_zhq
 GBqAdBtnXI5pGKnRKHyuauJhsgStyABY_ZMmhqQ18PYY1.a_jeumVVCRtgCzbJpe3lLEuBkfmIy3
 4rqkFo1Qsyw5Uh4JZvlkisKKN7tHFv5ROOG7GB80wXraf7bDxlx3Tpj13jnBDCyZn72qEaiLdbAR
 0glQq4.Gq2_nMXrnRL3Obfn4MweUisPAEJwhulK2wNFMUfrqN73XKpN2NPL.KErM4m7lwy90gcE8
 A32gCJf5C9pmcfI5UzOLlq3EYpwGZQM5aGuSu46V8WErxB_UOCLjbJ.cYcF9oQy8w_B2k2Masxwd
 2QCRT8mDFwewtxgtxWPLpXzTlbjfwo9LF88kKJ7X4sP_yOxqtn2pqzf7ujqZrKJyB40usTHgeAAg
 .fgfBKzv8xblB7QUDWHcVwWux_I79NpfGFd.oeJ9kWjKmAL7QtQTfGU.TMQtbZehhgZGoulniJrF
 8tDPk2cuVnk09Iahgccg.tzxlqJr36pgiSuCEAoocVNogqFkzvm4MuIlrOfeF45csHxtNAwnF6s0
 h1UEdSj18Cq3IHnyLqYd5ARPaNj13TZjGRuYWKtA1cIXVTjEIru8_kZWsEqrf0RxNx1hUyPTDcTg
 TUATiLN8Gfb5bJOrSiRUazUN3tbH9ECfaZFD.VZ_k0obNePA7GPLAuLqEfdMYRWqGhaDTpRjPcmQ
 xd8n.s97YThmm8havSOooiKfPNDwUEtzbdvh8XRnS4mcFHstmK1_Hoe6Npri6JBC36VDozxh0wN8
 T5wwnjMdrdrwqdpPhg1PMzz4r2lM3oZrYrwiju1AfinAmWpDPNR7yVWph3dq3WVA6IOebO0kiJDr
 vVrlrj63U.rAuUiIL7pTPWViqvAY79ykzItPbVw146OXUqVVne_Jk8lzOGny.F5C3l2Q9V9H9v.m
 WYCvW18WT3j2Hjl0RQId7ExjJQGx4iJlJ9QNyNQjWCm_7XnRhU6Ajur9TeZYQbdm9dIWVDfi0mgb
 OaM7cIUaZGqRwdRlDlJyfJ5vyEnUvkWxOJtVBO55GyjCM97cpXj3RGAMu2Rm0tk6ItwlG.x99IIP
 UkYE0qMvpvs5uJPrksfwaA_SjdMHhpczGoAZYMyvs3tJVstaYQxcY8gONbtNtVg17xjsUq.d3jWN
 wP0ECoghI00EC2CmjY9o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Jun 2019 23:47:34 +0000
Received: by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 61c6ab428a5947a0da3e2cd303da163c;
          Mon, 24 Jun 2019 23:47:31 +0000 (UTC)
Subject: Re: [PATCH V34 00/29] Lockdown as an LSM
To:     James Morris <jmorris@namei.org>,
        Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@amacapital.net>,
        John Johansen <john.johansen@canonical.com>,
        casey@schaufler-ca.com
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <alpine.LRH.2.21.1906250853290.7826@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <c5898a1e-e5c9-c63d-09d4-65fec0744613@schaufler-ca.com>
Date:   Mon, 24 Jun 2019 16:47:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1906250853290.7826@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/24/2019 4:01 PM, James Morris wrote:
> On Fri, 21 Jun 2019, Matthew Garrett wrote:
>
>> Minor updates over V33 - security_is_locked_down renamed to
>> security_locked_down, return value of security_locked_down is returned=

>> in most cases, one unnecessary patch was dropped, couple of minor nits=

>> fixed.
> Thanks for the respin.
>
> We are still not resolved on granularity. Stephen has said he's not sur=
e=20
> if a useful policy can be constructed with just confidentiality and=20
> integrity settings. I'd be interested to know JJ and Casey's thoughts o=
n=20
> lockdown policy flexibility wrt their respective LSMs.

Smack is a mandatory access control mechanism on named
objects controlled by the system. Issues of administrative
control, like whether hibernation is allowed, are outside
the scope of what Smack controls. There may be some subject/object
implications, but I have not identified any yet.

> These are also "all or nothing" choices which may prevent deployment du=
e=20
> to a user needing to allow (presumably controlled or mitigated) excepti=
ons=20
> to the policy.

