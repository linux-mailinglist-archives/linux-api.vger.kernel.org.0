Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05B40D214
	for <lists+linux-api@lfdr.de>; Thu, 16 Sep 2021 05:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhIPDkv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 23:40:51 -0400
Received: from dkpb0ek.cn ([106.75.27.222]:58620 "EHLO dkpb0ek.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhIPDkv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Sep 2021 23:40:51 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 23:40:51 EDT
Received: from mnj (unknown [122.226.180.195])
        by dkpb0ek.cn (Postfix) with ESMTPA id 71A35336B033
        for <linux-api@vger.kernel.org>; Thu, 16 Sep 2021 11:28:23 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dkpb0ek.cn; s=default;
        t=1631762903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FxnaP1pynOYhMUHa1+7gwlgB4KASZLwQyR2BJW/kG+g=;
        b=L0Ffq03s6+idfOKcyXIjV/nPrGRG4tvupGNNgykyk+3v8rzywP02o9IYJZKxQXJeqRscH3
        5zK2RG4gyDHQbCAaS8gm8LM3amyj3dOVQNtGij9BjnoPWIdHbRb2XAAonAGZ49PaJWc79g
        6XwlUaGUhtHXez7Q0FeYSmLai2d1LTo=
Message-ID: <20210916112823245042@dkpb0ek.cn>
From:   =?utf-8?B?RVRD44K144O844OT44K5?= <etc-update@dkpb0ek.cn>
To:     <linux-api@vger.kernel.org>
Subject: =?utf-8?B?RVRD44K144O844OT44K5?=
Date:   Thu, 16 Sep 2021 11:28:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-mailer: Lpf 1
X-Spam: Yes
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

RVRD44K144O844OT44K544KS44GU5Yip55So44Gu44GK5a6i5qeYOg0KDQpFVEPjgrXjg7zjg5Pj
grnjga/nhKHlirnjgavjgarjgorjgb7jgZfjgZ/jgIINCuW8leOBjee2muOBjeOCteODvOODk+OC
ueOCkuOBlOWIqeeUqOOBhOOBn+OBoOOBjeOBn+OBhOWgtOWQiOOBr+OAgeS4i+iomOODquODs+OC
r+OCiOOCiuips+e0sOOCkuOBlOeiuuiqjeOBj+OBoOOBleOBhOOAgg0KDQrkuIvoqJjjga7mjqXn
tprjgYvjgonlgZzmraLljp/lm6DjgpLnorroqo3jgZfjgabjgY/jgaDjgZXjgYQNCg0KaHR0cHM6
Ly9ldGMtbWVpc2FpLmpwLmZuLWluZm8udG9wLw0KDQoo55u05o6l44Ki44Kv44K744K544Gn44GN
44Gq44GE5aC05ZCI44Gv44CB5omL5YuV44Gn44OW44Op44Km44K244Gr44Kz44OU44O844GX44Gm
6ZaL44GE44Gm44GP44Gg44GV44GEKQ0KDQrigLvjgZPjga7jg6Hjg7zjg6vjga/pgIHkv6HlsILn
lKjjgafjgZnjgIINCuOAgOOBk+OBruOCouODieODrOOCueOBq+mAgeS/oeOBhOOBn+OBoOOBhOOB
puOCgui/lOS/oeOBhOOBn+OBl+OBi+OBreOBvuOBmeOBruOBp+OAgeOBguOCieOBi+OBmOOCgeOB
lOS6huaJv+mhmOOBhOOBvuOBmeOAgg0K4oC744Gq44GK44CB44GU5LiN5piO44Gq54K544Gr44Gk
44GN44G+44GX44Gm44Gv44CB44GK5omL5pWw44Gn44GZ44GM44CBDQogIEVUQ+OCteODvOODk+OC
ueS6i+WLmeWxgOOBq+OBiuWVj+OBhOWQiOOCj+OBm+OBj+OBoOOBleOBhOOAgg0KDQrilqBFVEPl
iKnnlKjnhafkvJrjgrXjg7zjg5Pjgrnkuovli5nlsYANCuW5tOS4reeEoeS8keOAgDk6MDDvvZ4x
ODowMA0K44OK44OT44OA44Kk44Ok44Or44CAMDU3MC0wMTAxMzkNCu+8iOODiuODk+ODgOOCpOOD
pOODq+OBjOOBlOWIqeeUqOOBhOOBn+OBoOOBkeOBquOBhOOBiuWuouOBleOBvuOAgDA0NS03NDQt
MTM3Mu+8iQ0KMDQ1LTc0NC01NzUNCg==


