Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170C75C1EB
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2019 19:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfGARZp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Jul 2019 13:25:45 -0400
Received: from sonic306-36.consmr.mail.bf2.yahoo.com ([74.6.132.235]:46138
        "EHLO sonic306-36.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728998AbfGARZp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Jul 2019 13:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562001944; bh=QFQXNGn0FJohU3l97Cng3z90qjIEAqAKmbCVyMu/adQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Io9NL4lnVvdtK8VRVGLxZ8rA/ytXf2PNU5x/h3MaFo7Hb7b2OPZLVGspmb61RE5rZ9PqqoN1esVCurf9vURU1fjUxFGdAfc1RP+6pIbuELIQsK6YEJvvo9XUz3UNWqC3A/I9SefoNQdRZowftz07ZMnSkG8l03MloiJDh7QJ2T8QFH+mg8e/eEvw0BnTX2KY+deFfnko+W6uhvmkfV7pEH7HsszQ4x7ofbhXn5ez0Ih/xKPBScb+g9lMQnvCoIpH5kwRfY8Bstg2pwgjZOVHQ9fT6mYWO6pWyjnmk5gfUvD4t2BFtSskDEvgHrgZkd/7+lyE2xVEsbkGOAtAsNtNLA==
X-YMail-OSG: owEhKTEVM1mxv1RUXQTuBXbn0W9dKpRWFvq52iZw927uEW2d0GbhsKKoutdQ5mg
 dGU1saTEaeA1Ua4tez5.glnlbkxwkjyj8xoYPT0Norx64ugkaR2JYtG3x_e24hoeB2_pzMN._KTN
 csaS1TLRinota2PsamLloCauxznnv8gK7VFbDTkT4kFnB93ENGfyq7Cw61vcR.nZfwpzWuuOivgh
 NbpzlwDzUw10slcKItdm5pHiwFFU6PCpH5NfPYkvFk7E_ziSe7C_7yQvr2L2j8tZ7lfjOeBN6lI5
 l8aR6HAIx1WTilOL7VPA12AY_eEGHnmS1h4gONIxQQwTI3kXzV8xg8AB7sPecjDYlzOjIO5uvOd1
 Wj94UDglNfEi2NCqyR9wdfWT39rP23z8uU0KXdk9q2x6vVxuaDawvdZ1sTwGBmzkYxzurZZXc_J_
 33i7POi0DVCPwTqhnbZrud1BWXsActRCNQqmPuZejfXpZ8vABmW7dwq4qZjXnjNhCXoCu2UxHczf
 7qt.xqlJwGM3VzgpFoM.rXq8ZueI1HWHCDH4S_2YlMoUEEpSt4JPmeXtI7Ra1Vb2UNXR0brHzJfF
 KfQ_mXPoAauW28R2As0GzLupY0G636TEKi7fBJ.IO16rO5052oteu.ytXVZKABNrOrgbnwR42xCK
 3muMi3FxqqKhtNKHNJtbe7IreDxQcxYivAgLayMg0H34OgwCufWCBT2jawMGSb2MJ.kzFG4x_4xX
 gaTFy05qOaOti2xY3XGfklWDlPCGolBij_39hsMR5mwcDn7d9vKYGJ2CqafP52e8TZr2QYN2312u
 t4OUsc6MXuDF4bXFWajw4fWtFoabYxpwG696d5lA9F4Mg.sIIv1HCVX.Hdhp1eKWhFfbsY5p4.ON
 FrgrUnrjTyFU5q14Vr6d19NJ48V7JXsgXE1DtAkOPHM3ZJJ4jVfLDn2YbScldfYFySMaBnySKrrF
 rRsxPI1JCZku9W5alhmadWIrAYEKuWTvd0whTblF6P3eUb36U9a1aE_JsoSai3vnJK3Xg2oEnTpJ
 _13MQFLB19xZdPC.wApMJ36M0mI48khQdUtxnEXKpDPhSb5OzkDt7rswiJQBdyehWnkG_9pysHB0
 MGtsheKxCDoAgJNdoTNFh2SYI0_iOewtvN0nHtYg342EbgcIuktrJsdCRx.xNwJm6sVTkHSPrVeK
 oWqY_Mv.f77QEUGU.UJKWrwdwykVQhz6bzCRI48_TSS.iOCcRirarGmQDskknQhsjYqx4h8dfJbh
 aByTVMD_ziSGfLJC4sn2e3NU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Mon, 1 Jul 2019 17:25:44 +0000
Date:   Mon, 1 Jul 2019 17:23:43 +0000 (UTC)
From:   Major Dennis Hornbeck <bc65@bacman.online>
Reply-To: Major Dennis Hornbeck <hornbeckmajordennis637@gmail.com>
Message-ID: <1468183126.914512.1562001823079@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1468183126.914512.1562001823079.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13913 YahooMailBasic Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I am in the military unit here in Afghanistan, we have some amount of funds that we want to move out of the country. My partners and I need a good partner someone we can trust. It is risk free and legal. Reply to this email: hornbeckmajordennis637@gmail.com

Regards,
Major Dennis Hornbeck.
